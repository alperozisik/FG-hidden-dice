# Testing Record

This record separates completed manual evidence from the checks still required before the first Forge listing.

## Completed evidence

### v0.1.0

- Loaded the packaged extension in separate GM and player Fantasy Grounds sessions.
- Observed no Hidden Dice Lua or script errors during the tested session.
- Verified that a player hidden-roll hotbar shortcut routes through the dice tower: the player receives dice-tower submission feedback and the GM receives the result.
- Verified the original per-roll and GM-wide behaviors during development.

### v0.1.1

- Reproduced a Requested Rolls conflict in which Hidden Dice could alter Requested Rolls handling.
- Added the `rRoll.RR` bypass and manually confirmed the Requested Rolls scenario after installation.
- Published `HiddenDice.ext` with SHA-256 `EA7ECA1BC8CD5276D1CC03BC074AB9D16B7ED1251B44A8B1D48E437AFC7A232B`.

### v0.1.2

- Renamed the packaged MIT license from extensionless `LICENSE` to Forge-compatible `LICENSE.txt` while retaining `LICENSE` in the source repository.
- Added build-time and post-archive validation against the Fantasy Grounds Forge file-extension whitelist.
- Built a seven-file `HiddenDice.ext` package with no whitelist violations and SHA-256 `A8DEF971C1D2302B9D70EB840FD984E78FE384F0577B984E23CDB6952E2946EC`.
- Confirmed that two consecutive builds produced the same SHA-256 hash.
- No runtime behavior changed in this packaging-only release.

## Forge release-candidate checklist

Run these checks with synthetic characters after the other live Fantasy Grounds test work is complete.

### Environment

- Record the exact Fantasy Grounds application version.
- Record the exact 5E ruleset release.
- Run the core matrix once with only Hidden Dice enabled.
- Repeat the Requested Rolls cases with only Hidden Dice and Requested Rolls enabled.
- Exercise both 2014 and 2024 character/content paths before claiming separately tested support for both.

### GM and player matrix

For ability checks, saving throws, skills, initiative, and death saves:

- Visible button roll.
- Hidden button roll.
- Drag roll from the button.
- Double-click related modifier or total field in **Button & Modifier** mode.
- Drag from the related field in **Button & Modifier** mode.
- Confirm the related field is unaffected in **Button only** mode.
- Create visible and hidden hotbar shortcuts, reconnect the player, and roll both shortcuts.
- Change the source roll after shortcut creation and confirm that the existing shortcut retains its captured state.

### GM-wide controls

- Use **Set hidden for all** and confirm the matching roll changes on every synthetic character.
- Use **Set visible for all** and confirm the matching roll changes on every synthetic character.
- Confirm the GM-only actions are not offered to a player.
- Reload the campaign and confirm stored states persist.

### Requested Rolls regression

- Request a player roll configured as visible in Requested Rolls.
- Request a player roll configured as hidden in Requested Rolls.
- Request a GM roll with automatic rolling disabled and confirm the GM roll window appears.
- Request a GM roll with automatic rolling enabled and confirm Requested Rolls performs it.
- Repeat with the corresponding Hidden Dice character-sheet roll set both hidden and visible; Requested Rolls behavior must remain unchanged.

### Presentation and compatibility

- Repeat the visual icon check under the default theme and at least one alternate theme.
- Confirm no hover state shows the wrong d20 or dice-tower icon after toggling back to visible.
- Confirm the chat output does not reveal hidden result details to the player.
- Check the console after each matrix for Lua errors.
