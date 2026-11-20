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

Focused native Fantasy Grounds QA was run on 2026-11-20 in a separate synthetic campaign with a separately named QA extension package. The existing installed `HiddenDice.ext` and live campaigns were not used or overwritten.

- Fantasy Grounds v5.1.15 (2026-10-28).
- Dungeons and Dragons (5E) ruleset (2026-10-06).
- Default theme; only the separately named Hidden Dice QA package enabled.
- Verified the normal d20 button changes to the theme-native dice-tower button and returns to the normal d20 after toggling visible.
- Verified the GM-only radial actions are present.
- Verified **Set hidden for all** and **Set visible for all** across two synthetic characters.
- Verified the hidden global state remains after closing and reopening the synthetic campaign.
- Verified player hidden rolls show tower submission feedback without the result, while the GM sees the tower results. A visible control roll showed the result to the player.
- Verified the player radial menu does not show the GM-only global actions.
- No Hidden Dice Lua error was observed during the focused session.

The following v0.1.2 gaps remain explicit:

- The **Hidden Dice Handle** entry could not be found in the Options window on this FG/5E build, so the **Button & Modifier** versus **Button only** boundary was not re-verified in this session.
- Requested Rolls was not enabled in this focused packaging check. The v0.1.1 `rRoll.RR` bypass remains the latest direct Requested Rolls evidence; v0.1.2 does not change runtime code.
- Physical hotbar drag-and-drop was not repeated. The latest direct hotbar evidence remains v0.1.0.
- The 2014/2024 content paths, alternate themes, additional Requested Rolls variants, and the complete supported-roll matrix were not rerun.

## Forge release-candidate checklist

Run the remaining checks with synthetic characters before claiming broader compatibility than the focused evidence above.

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
