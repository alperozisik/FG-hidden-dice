# Forge Publishing Copy

This file contains the prepared copy and asset checklist for the first Fantasy Grounds Forge listing. Replace bracketed placeholders before publishing.

## Documentation synchronization checklist

- Update `README.md`, this Forge listing draft, screenshots, and the complete Settings value/default/scope notes together when user-facing behavior changes.
- If a translated guide is added later, update it in the same documentation change.
- After the Forge item is published, apply the same approved copy and image changes to the live listing in the same release-documentation pass.

## Short description

Secret Stealth checks? Hidden knowledge rolls? Choose which 5E character-sheet rolls default to hidden and which stay public.

## Long description

Hidden Dice is a free Fantasy Grounds Unity extension for the D&D 5E ruleset. It lets the GM decide which supported character-sheet rolls default to hidden and which remain public, without replacing the active theme's graphics.

A low visible Stealth result can change how a player behaves before the character has discovered anything. A visible History or Arcana result can reveal whether the information they receive is likely to be trustworthy. Hidden Dice preserves that uncertainty: players use the familiar sheet controls, while hidden results go to the GM behind the screen.

### Requirements

- Fantasy Grounds Unity
- D&D 5E ruleset, release 9 or later

### Features

- Choose the default hidden or visible state independently for supported rolls on each character sheet.
- Supports ability checks, saving throws, skills, initiative, and death saves.
- Uses the active ruleset or theme's normal-roll and dice-tower button resources.
- Applies the selected state to related modifier or total fields when **Hidden Dice Handle** is set to **Button & Modifier**.
- Preserves the selected hidden or visible state in newly created hotbar shortcuts.
- Lets the GM set the matching roll to hidden or visible for every character at once, while also establishing the campaign default for that matching roll.
- Stores per-character choices and GM-wide defaults in the campaign.

### Usage

Right-click a supported d20 roll button and choose **Toggle hidden roll** for that character. The button displays the active theme's dice-tower icon while hidden rolling is enabled.

The GM also receives **Set hidden for all** and **Set visible for all** radial-menu actions. These apply the matching roll to every existing character and establish its campaign default. For example, set Stealth hidden across the party, leave Persuasion public, and give one character an individual Stealth override when needed.

The campaign option **Hidden Dice Handle** provides two modes:

- **Button & Modifier** (default): the selected state applies to supported roll buttons and related modifier or total fields, including field double-clicks, field drag rolls, and newly created hotbar shortcuts.
- **Button only:** automatic Hidden Dice handling is limited to supported roll buttons. Related modifier or total fields do not inherit the setting.

This GM-controlled campaign option is managed by CoreRPG's Options system. It controls **which controls use the selected state**, not which checks are secret. Choose each roll's hidden/visible state through its radial menu. v0.1.3 QA verified that the selection remained after closing and reopening the Options window; a full campaign reload of this option value was not repeated for that release. Existing hotbar shortcuts retain the state captured when they were created; recreate them when they should adopt a changed source state.

### Requested Rolls compatibility

Rolls initiated by Requested Rolls bypass Hidden Dice in either handling mode. Requested Rolls therefore retains control of player prompts, GM rolls, and result visibility. Character-sheet rolls and Hidden Dice hotbar shortcuts continue to use their configured state. The latest direct Requested Rolls regression evidence is from Hidden Dice v0.1.1; this combination was not repeated for v0.1.3.

### Installation and updates

Add Hidden Dice to your Forge inventory and run **Check for Updates** from the Fantasy Grounds launcher. Enable **Hidden Dice** when loading a 5E campaign. Future Forge versions are delivered through the same updater.

### Support

Source, release notes, and bug reports: https://github.com/alperozisik/FG-hidden-dice

License: MIT. Hidden Dice is free.

## Forum opening post

### Suggested title

`[Extension] Hidden Dice (5E)`

### Post body

Hidden Dice is a free Fantasy Grounds Unity extension for the D&D 5E ruleset. It lets the GM decide which supported character-sheet rolls default to hidden and which stay public, without requiring players to drag every secret roll to the dice tower manually.

Use hidden Stealth checks when the character should not know how well they concealed themselves. Hide History or Arcana checks when the visible result would reveal too much about the reliability of the information the GM provides. Players keep using the normal character-sheet controls.

**Forge:** [Forge item URL]

**Source and releases:** https://github.com/alperozisik/FG-hidden-dice

**Current version:** v0.1.3

**Requirements:** Fantasy Grounds Unity and the D&D 5E ruleset, release 9 or later.

Supported rolls include ability checks, saving throws, skills, initiative, and death saves. Right-click a supported d20 button to toggle hidden rolling for that character. GMs also receive **Set hidden for all** and **Set visible for all**, which apply the matching roll across existing characters and establish its campaign default.

Under **Options → Game**, the GM-controlled **Hidden Dice Handle** campaign option has two values:

- **Button & Modifier** (default): supported buttons, related modifier or total fields, field double-clicks, field drag rolls, and newly created hotbar shortcuts use the selected state.
- **Button only:** automatic handling is limited to supported roll buttons.

This option determines which controls honor the selected state; it does not choose which checks are hidden. CoreRPG manages it as a campaign option. v0.1.3 verified retention after closing and reopening Options, but did not repeat a full campaign reload for this value. Existing hotbar shortcuts retain their captured state and must be recreated when they should adopt a change.

Requested Rolls requests bypass Hidden Dice, allowing Requested Rolls to retain control of prompts, GM rolls, and result visibility. The latest direct regression evidence for this integration is from v0.1.1; it was not repeated for v0.1.3.

Installation is handled through the Forge and Fantasy Grounds updater. Add the item to your Forge inventory, run **Check for Updates**, and enable **Hidden Dice** when loading a 5E campaign.

When reporting a problem, please include:

- Fantasy Grounds version
- 5E ruleset version
- Hidden Dice version
- Other enabled extensions
- Roll type and exact reproduction steps
- Console error text, if any

### Changelog

- **v0.1.3:** Restored the **Hidden Dice Handle** campaign option in the current CoreRPG Options window.
- **v0.1.2:** Updated the extension package for the Fantasy Grounds Forge file whitelist. The MIT license is included as `LICENSE.txt`, and the build now rejects unsupported file types.
- **v0.1.1:** Added Requested Rolls compatibility so Requested Rolls controls its own delivery and visibility.
- **v0.1.0:** Initial release.

## Product image guidance

Hidden Dice intentionally contains no replacement graphics. The d20 and dice-tower resources used at runtime belong to the active Fantasy Grounds ruleset or theme and should not be copied into the Forge artwork.

Use `docs/forge/images/hidden-dice-cover-forge.jpg` as the first Forge image. It is original promotional artwork, not a Fantasy Grounds screenshot or runtime resource. The cover communicates a concealed d20 and dice-tower concept without reproducing Fantasy Grounds theme assets.

The cover is a 1200 x 800 JPEG below 300 KB. Its generation prompt is recorded in `docs/forge/image-prompt.txt`. The source PNG is retained outside this repository as the archival original; only the Forge-ready JPEG belongs in the repository.

Use `docs/forge/images/hidden-dice-icon.png` as the small product or listing icon where a square raster image is required. The matching editable source is `docs/forge/images/hidden-dice-icon.svg`. This original mark combines a dice tower, a partially concealed d20, and a GM screen; it does not reuse Fantasy Grounds or theme artwork.

The product icon is a marketing asset only. Do not add it to the extension runtime package or use it to replace the theme-native character-sheet roll and dice-tower resources.

## Required real product screenshots

Three real product screenshots from isolated synthetic QA campaigns are included. Each is a tightly cropped JPEG below 300 KB:

1. `docs/forge/images/hidden-dice-hidden-icon.jpg` shows the theme-native dice-tower button on a synthetic character sheet.
2. `docs/forge/images/hidden-dice-options.jpg` shows the **Hidden Dice Handle** campaign option and its default **Button & Modifier** value on Fantasy Grounds v5.1.15.
3. `docs/forge/images/hidden-dice-privacy-feedback.jpg` shows GM-side private tower results alongside a visible control roll.

The screenshots use synthetic characters and roll data and do not show a live campaign name or server alias.
