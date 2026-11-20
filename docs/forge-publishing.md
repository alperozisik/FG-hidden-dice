# Forge Publishing Copy

This file contains the prepared copy and asset checklist for the first Fantasy Grounds Forge listing. Replace bracketed placeholders before publishing.

## Short description

Choose which 5E character-sheet checks, saves, skills, initiative rolls, and death saves use the dice tower by default.

## Long description

Hidden Dice is a free Fantasy Grounds Unity extension for the D&D 5E ruleset. It lets players and GMs choose which supported character-sheet rolls use the dice tower by default without replacing the active theme's graphics.

### Requirements

- Fantasy Grounds Unity
- D&D 5E ruleset, release 9 or later

### Features

- Toggle hidden rolling independently for supported rolls on each character sheet.
- Supports ability checks, saving throws, skills, initiative, and death saves.
- Uses the active ruleset or theme's normal-roll and dice-tower button resources.
- Applies the selected state to related modifier or total fields when **Hidden Dice Handle** is set to **Button & Modifier**.
- Preserves the selected hidden or visible state in newly created hotbar shortcuts.
- Lets the GM set the matching roll to hidden or visible for every character at once.
- Stores settings per character and roll.

### Usage

Right-click a supported d20 roll button and choose **Toggle hidden roll**. The button displays the active theme's dice-tower icon while hidden rolling is enabled.

The GM also receives **Set hidden for all** and **Set visible for all** radial-menu actions. These apply the selected roll setting to every character sheet.

The campaign option **Hidden Dice Handle** provides two modes:

- **Button & Modifier** (default): buttons, related modifier fields, drag rolls, double-click rolls, and newly created hotbar shortcuts use the selected state.
- **Button only:** automatic handling is limited to the roll button.

### Requested Rolls compatibility

Rolls initiated by Requested Rolls bypass Hidden Dice. Requested Rolls therefore retains control of player prompts, GM rolls, and result visibility. Character-sheet rolls and Hidden Dice hotbar shortcuts continue to use their configured state.

### Installation and updates

Add Hidden Dice to your Forge inventory and run **Check for Updates** from the Fantasy Grounds launcher. Enable **Hidden Dice** when loading a 5E campaign. Future Forge versions are delivered through the same updater.

### Support

Source, release notes, and bug reports: https://github.com/alperozisik/FG-hidden-dice

License: MIT. Hidden Dice is free.

## Forum opening post

### Suggested title

`[Extension] Hidden Dice (5E)`

### Post body

Hidden Dice is a free Fantasy Grounds Unity extension for the D&D 5E ruleset. It changes the default handling of selected character-sheet rolls so they use the dice tower without requiring the player to drag every roll to the tower manually.

**Forge:** [Forge item URL]

**Source and releases:** https://github.com/alperozisik/FG-hidden-dice

**Current version:** v0.1.2

**Requirements:** Fantasy Grounds Unity and the D&D 5E ruleset, release 9 or later.

Supported rolls include ability checks, saving throws, skills, initiative, and death saves. Right-click a supported d20 button to toggle hidden rolling. GMs also receive radial-menu actions that set the matching roll to hidden or visible for every character sheet.

The **Hidden Dice Handle** campaign option controls whether the setting applies to both the button and related modifier fields or to the button only. Newly created hotbar shortcuts preserve the state active when they are created.

Requested Rolls requests bypass Hidden Dice, allowing Requested Rolls to retain control of prompts, GM rolls, and result visibility.

Installation is handled through the Forge and Fantasy Grounds updater. Add the item to your Forge inventory, run **Check for Updates**, and enable **Hidden Dice** when loading a 5E campaign.

When reporting a problem, please include:

- Fantasy Grounds version
- 5E ruleset version
- Hidden Dice version
- Other enabled extensions
- Roll type and exact reproduction steps
- Console error text, if any

### Changelog

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

Three real product screenshots from the isolated synthetic v0.1.2 QA campaign are included. Each is a tightly cropped JPEG below 300 KB:

1. `docs/forge/images/hidden-dice-hidden-icon.jpg` shows the theme-native dice-tower button on a synthetic character sheet.
2. `docs/forge/images/hidden-dice-radial-menu.jpg` shows **Toggle hidden roll** and the GM-only **Set hidden for all** and **Set visible for all** actions.
3. `docs/forge/images/hidden-dice-privacy-feedback.jpg` shows GM-side tower results alongside a visible control roll.

The screenshots use synthetic characters and roll data and do not show a live campaign name or server alias. An Options screenshot is intentionally not included because the **Hidden Dice Handle** entry was not located during the current FG v5.1.15 focused check; that gap is recorded in `docs/testing.md`.
