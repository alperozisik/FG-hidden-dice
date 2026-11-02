local _tControls = {};
local _cPendingRoll = nil;

local _fOriginalPerformAction = nil;
local _fOriginalActionHotkey = nil;
local _fOriginalActionDrop = nil;

local HIDDEN_ROLL_MARKER = "[HIDDENDICE]";
local OPTION_HANDLE_MODE = "HDHM";

local function encodeKey(sKey)
	return (sKey:gsub("[^%w_]", function(sChar)
		return string.format("_%02X", string.byte(sChar));
	end));
end

local function findCharacterNode(node)
	while node do
		local sPath = DB.getPath(node);
		if sPath and sPath:match("^charsheet%.[^%.]+$") then
			return node;
		end
		node = DB.getParent(node);
	end
	return nil;
end

local function getControlKey(c)
	if not c or not c.window then
		return nil, nil;
	end

	local nodeContext = c.window.getDatabaseNode();
	local nodeChar = findCharacterNode(nodeContext);
	if not nodeChar then
		return nil, nil;
	end

	local sControlName = c.getName() or "";
	local sAbility = sControlName:match("^button_([%a]+)_check$");
	if sAbility then
		return "ability_check:" .. sAbility:lower(), nodeChar;
	end

	sAbility = sControlName:match("^button_([%a]+)_save$");
	if sAbility then
		return "ability_save:" .. sAbility:lower(), nodeChar;
	end

	if sControlName == "button_initiative_roll" then
		return "initiative", nodeChar;
	end
	if sControlName == "deathsave_roll" then
		return "death_save", nodeChar;
	end

	if sControlName == "button_roll" then
		local sContextPath = DB.getPath(nodeContext) or "";
		local sSkill = DB.getValue(nodeContext, "name", "");
		if sContextPath:match("%.skilllist%.") and sSkill ~= "" then
			return "skill:" .. StringManager.trim(sSkill):lower(), nodeChar;
		end
	end

	return nil, nil;
end

local function getStatePath(nodeChar, sKey)
	return DB.getPath(nodeChar, "_hiddendice", encodeKey(sKey));
end

local function getGlobalStatePath(sKey)
	return "hiddendice.defaults." .. encodeKey(sKey);
end

local function getState(tInfo)
	local nState = DB.getValue(tInfo.nodeChar, "_hiddendice." .. encodeKey(tInfo.sKey), -1);
	if nState < 0 then
		nState = DB.getValue(getGlobalStatePath(tInfo.sKey), 0);
	end
	return nState == 1;
end

local function getRollInfo(rActor, rRoll)
	if not rActor or not rRoll or not ActorManager.isPC(rActor) then
		return nil;
	end

	local nodeChar = ActorManager.getCreatureNode(rActor);
	if not nodeChar or not (DB.getPath(nodeChar) or ""):match("^charsheet%.[^%.]+$") then
		return nil;
	end

	local sKey;
	if rRoll.sType == "check" then
		local sAbility = ActionCore.decodeLabelText(rRoll.sDesc or "", "action_check_tag");
		if (sAbility or "") ~= "" then
			sKey = "ability_check:" .. sAbility:lower();
		end
	elseif rRoll.sType == "save" then
		local sAbility = ActionSaveCore.decodeLabelText(rRoll.sDesc or "");
		if (sAbility or "") ~= "" then
			sKey = "ability_save:" .. sAbility:lower();
		end
	elseif rRoll.sType == "skill" then
		local sSkill = rRoll.sSkill;
		if (sSkill or "") == "" then
			sSkill = ActionCore.decodeLabelText(rRoll.sDesc or "", "action_skill_tag");
		end
		if (sSkill or "") ~= "" then
			sKey = "skill:" .. StringManager.trim(sSkill):lower();
		end
	elseif rRoll.sType == "init" then
		sKey = "initiative";
	elseif rRoll.sType == "death" then
		sKey = "death_save";
	end

	if not sKey then
		return nil;
	end
	return { sKey = sKey, nodeChar = nodeChar, };
end

local function setCharacterState(nodeChar, sKey, bHidden)
	DB.setValue(nodeChar, "_hiddendice." .. encodeKey(sKey), "number", bHidden and 1 or 0);
end

local function refreshMatchingControls(sKey)
	for c,tInfo in pairs(_tControls) do
		if tInfo.sKey == sKey then
			HiddenDiceManager.refreshControl(c);
		end
	end
end

local function rollThroughTower(rActor, rRoll)
	rRoll.bHiddenDice = true;
	rRoll.bTower = true;
	rRoll.bSecret = true;

	ActionsManager.lockModifiers();
	local bModStackUsed = ActionsManager.applyModifiers(rActor, nil, rRoll);
	ActionsManager.unlockModifiers(bModStackUsed);

	DiceTowerManager.sendRoll(rRoll, rActor);
	return true;
end

local function markDragHidden(draginfo)
	for i = 1, draginfo.getSlotCount() do
		draginfo.setSlot(i);
		local sDesc = draginfo.getStringData() or "";
		if sDesc:sub(1, #HIDDEN_ROLL_MARKER) ~= HIDDEN_ROLL_MARKER then
			draginfo.setStringData(HIDDEN_ROLL_MARKER .. sDesc);
		end
	end
end

local function dragHasHiddenMarker(draginfo)
	for i = 1, draginfo.getSlotCount() do
		draginfo.setSlot(i);
		local sDesc = draginfo.getStringData() or "";
		if sDesc:sub(1, #HIDDEN_ROLL_MARKER) == HIDDEN_ROLL_MARKER then
			return true;
		end
	end
	return false;
end

local function prepareMarkedRoll(rRoll)
	local sDesc = rRoll.sDesc or "";
	if sDesc:sub(1, #HIDDEN_ROLL_MARKER) ~= HIDDEN_ROLL_MARKER then
		return false;
	end

	rRoll.sDesc = sDesc:sub(#HIDDEN_ROLL_MARKER + 1);
	rRoll.bHiddenDice = true;
	rRoll.bTower = true;
	rRoll.bSecret = true;
	return true;
end

local function sendMarkedDragToTower(draginfo)
	local rSource, rRolls = ActionsManager.decodeActionFromDrag(draginfo, false);
	if not rSource and not Session.IsHost then
		local sIdentity = User.getCurrentIdentity();
		if (sIdentity or "") ~= "" then
			rSource = ActorManager.resolveActor("charsheet." .. sIdentity);
		end
	end

	for _,rRoll in ipairs(rRolls or {}) do
		prepareMarkedRoll(rRoll);
	end

	ActionsManager.lockModifiers();
	local bModStackUsed = ActionsManager.applyModifiersToRolls(rSource, nil, rRolls);
	ActionsManager.unlockModifiers(bModStackUsed);

	for _,rRoll in ipairs(rRolls or {}) do
		DiceTowerManager.sendRoll(rRoll, rSource);
	end
	return true;
end

function onInit()
	OptionsManager.registerOptionData({
		sKey = OPTION_HANDLE_MODE,
		sGroupRes = "option_header_game",
		tCustom = {
			labelsres = "hiddendice_option_handle_button_only",
			values = "button",
			baselabelres = "hiddendice_option_handle_button_modifier",
			baseval = "both",
			default = "both",
		},
	});

	_fOriginalPerformAction = ActionsManager.performAction;
	ActionsManager.performAction = HiddenDiceManager.performAction;
	_fOriginalActionHotkey = ActionsManager.actionHotkey;
	ActionsManager.actionHotkey = HiddenDiceManager.actionHotkey;
	_fOriginalActionDrop = ActionsManager.actionDrop;
	ActionsManager.actionDrop = HiddenDiceManager.actionDrop;
end

function onTabletopInit()
	if Session.IsHost then
		local nodeRoot = DB.createNode("hiddendice");
		DB.setPublic(nodeRoot, true);
	end
end

function onClose()
	if ActionsManager.performAction == HiddenDiceManager.performAction then
		ActionsManager.performAction = _fOriginalPerformAction;
	end
	if ActionsManager.actionHotkey == HiddenDiceManager.actionHotkey then
		ActionsManager.actionHotkey = _fOriginalActionHotkey;
	end
	if ActionsManager.actionDrop == HiddenDiceManager.actionDrop then
		ActionsManager.actionDrop = _fOriginalActionDrop;
	end
end

function registerControl(c, sNormalIcon, sPressedIcon)
	local sKey, nodeChar = getControlKey(c);
	if not sKey then
		return nil;
	end

	local tInfo = {
		sKey = sKey,
		nodeChar = nodeChar,
		sNormalIcon = sNormalIcon,
		sPressedIcon = sPressedIcon,
	};
	tInfo.sStatePath = getStatePath(nodeChar, sKey);
	_tControls[c] = tInfo;

	HiddenDiceManager.refreshControl(c);
	return tInfo;
end

function unregisterControl(c)
	if _cPendingRoll == c then
		_cPendingRoll = nil;
	end
	_tControls[c] = nil;
end

function refreshControl(c)
	local tInfo = _tControls[c];
	if not tInfo then
		return;
	end

	if getState(tInfo) then
		c.setIcons("dicetower_icon", "dicetower_icon", "dicetower_icon");
	else
		c.setIcons(tInfo.sNormalIcon, tInfo.sPressedIcon, tInfo.sNormalIcon);
	end
end

function toggleControl(c)
	local tInfo = _tControls[c];
	if not tInfo then
		return;
	end

	local bHidden = not getState(tInfo);
	setCharacterState(tInfo.nodeChar, tInfo.sKey, bHidden);
	refreshMatchingControls(tInfo.sKey);
end

function setControlForAll(c, bHidden)
	if not Session.IsHost then
		return;
	end

	local tInfo = _tControls[c];
	if not tInfo then
		return;
	end

	DB.setValue(getGlobalStatePath(tInfo.sKey), "number", bHidden and 1 or 0);
	for _,nodeChar in ipairs(DB.getChildList("charsheet")) do
		setCharacterState(nodeChar, tInfo.sKey, bHidden);
	end

	refreshMatchingControls(tInfo.sKey);
end

function prepareControlRoll(c)
	if _tControls[c] then
		_cPendingRoll = c;
	end
end

function onControlHover(c, bOnControl)
	if not bOnControl and _cPendingRoll == c then
		_cPendingRoll = nil;
	end
end

function performAction(draginfo, rActor, rRoll)
	local c = _cPendingRoll;
	_cPendingRoll = nil;

	-- Requested Rolls owns its roll-routing workflow. Let it decide whether a
	-- request is shown to the player, rolled by the GM, or sent to the tower.
	if rRoll and rRoll.RR then
		return _fOriginalPerformAction(draginfo, rActor, rRoll);
	end

	local tInfo = c and _tControls[c] or nil;
	if not tInfo and OptionsManager.isOption(OPTION_HANDLE_MODE, "both") then
		tInfo = getRollInfo(rActor, rRoll);
	end

	if not tInfo or not getState(tInfo) then
		return _fOriginalPerformAction(draginfo, rActor, rRoll);
	end

	rRoll.bHiddenDice = true;
	rRoll.bTower = true;
	rRoll.bSecret = true;
	if draginfo then
		local bResult = _fOriginalPerformAction(draginfo, rActor, rRoll);
		markDragHidden(draginfo);
		return bResult;
	end

	return rollThroughTower(rActor, rRoll);
end

function actionHotkey(draginfo)
	if dragHasHiddenMarker(draginfo) then
		return sendMarkedDragToTower(draginfo);
	end
	return _fOriginalActionHotkey(draginfo);
end

function actionDrop(draginfo, rTarget)
	if dragHasHiddenMarker(draginfo) then
		return sendMarkedDragToTower(draginfo);
	end
	return _fOriginalActionDrop(draginfo, rTarget);
end
