local _bHiddenDiceEligible = false;
local _sHiddenDiceStatePath = nil;

function onInit()
	local sNormal = "button_roll";
	local sPressed = "button_roll_down";
	if hiddendice_normal and hiddendice_normal[1] then
		sNormal = hiddendice_normal[1];
	end
	if hiddendice_pressed and hiddendice_pressed[1] then
		sPressed = hiddendice_pressed[1];
	end

	local tInfo = HiddenDiceManager.registerControl(self, sNormal, sPressed);
	if not tInfo then
		return;
	end

	_bHiddenDiceEligible = true;
	_sHiddenDiceStatePath = tInfo.sStatePath;
	registerMenuItem(Interface.getString("hiddendice_menu_toggle"), "dicetower_icon", 8);
	if Session.IsHost then
		registerMenuItem(Interface.getString("hiddendice_menu_set_hidden_all"), "dicetower_icon", 2);
		registerMenuItem(Interface.getString("hiddendice_menu_set_visible_all"), "visibilityon", 1);
	end
	DB.addHandler(_sHiddenDiceStatePath, "onUpdate", onHiddenDiceStateChanged);
end

function onClose()
	if _sHiddenDiceStatePath then
		DB.removeHandler(_sHiddenDiceStatePath, "onUpdate", onHiddenDiceStateChanged);
	end
	HiddenDiceManager.unregisterControl(self);
end

function onHiddenDiceStateChanged()
	HiddenDiceManager.refreshControl(self);
end

function onClickDown(button, x, y)
	if _bHiddenDiceEligible and button == 1 then
		HiddenDiceManager.prepareControlRoll(self);
	end
end

function onHover(bOnControl)
	if not _bHiddenDiceEligible then
		return;
	end
	HiddenDiceManager.onControlHover(self, bOnControl);
end

function onMenuSelection(selection)
	if not _bHiddenDiceEligible then
		return;
	end

	if selection == 8 then
		HiddenDiceManager.toggleControl(self);
	elseif Session.IsHost and selection == 2 then
		HiddenDiceManager.setControlForAll(self, true);
	elseif Session.IsHost and selection == 1 then
		HiddenDiceManager.setControlForAll(self, false);
	end
end
