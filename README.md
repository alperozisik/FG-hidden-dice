# Hidden Dice

Hidden Dice is a Fantasy Grounds Unity extension for the D&D 5E ruleset. It lets players choose which character-sheet rolls use the dice tower by default while preserving the active Fantasy Grounds theme.

The extension does not include replacement graphics. Normal-roll and dice-tower buttons use the resources supplied by the active ruleset or theme.

## Features

- Toggle hidden rolling independently for supported rolls on each character sheet.
- Reuse the selected hidden or visible state when rolling from related modifier fields.
- Preserve the selected state when creating a hotbar shortcut.
- Let the GM set the matching roll to hidden or visible for every character at once.
- Store settings per character and roll.

Supported roll types:

- Ability checks
- Saving throws
- Skills
- Initiative
- Death saves

## Usage

Right-click a supported d20 roll button to open its radial menu.

- **Toggle hidden roll** changes the state of that roll for the current character.
- **Set hidden for all** is available to the GM and hides the matching roll on every character sheet.
- **Set visible for all** is available to the GM and makes the matching roll visible on every character sheet.

The button displays the active theme's dice-tower icon when hidden rolling is enabled and its normal d20 icon when disabled.

## Campaign option

The **Hidden Dice Handle** option is available in the Fantasy Grounds campaign settings:

- **Button & Modifier** (default) applies the selected state to the roll button and its related modifier or total field. Dragging a roll, creating a hotbar shortcut, or double-clicking the field uses the selected hidden or visible state.
- **Button only** limits automatic hidden-roll handling to the roll button.

## Hotbar shortcuts

A shortcut records the hidden or visible state that was active when it was created. Recreate an existing shortcut after changing the roll state if the shortcut should use the new behavior.

For hidden player rolls, the player receives the normal dice-tower submission feedback while the GM receives the result.

## Compatibility

- Fantasy Grounds Unity
- D&D 5E ruleset, release 9 or later
- Requested Rolls requests bypass Hidden Dice so that Requested Rolls retains control of player prompts, GM rolls, and result visibility.

## Build

Run the build script from PowerShell:

```powershell
./build.ps1
```

The packaged extension is written to `dist/HiddenDice.ext`.

## Installation

Copy either the project directory or `dist/HiddenDice.ext` into the `extensions` directory under the Fantasy Grounds data directory. When both are present, Fantasy Grounds loads the project directory before the packaged `.ext` file with the same internal extension name.

Enable **Hidden Dice** when loading a 5E campaign.
