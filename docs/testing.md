# Verification

## Recorded Studio result

The Competitive card was opened on desktop and on a landscape iPhone 17 Pro emulator. The label and value shared each stat column's center on both. Both button gaps measured 6 pixels, including the space under Highlights. Studio loaded the custom backpack, magnifier and replay artwork. The phone sheet grew to show the complete card and restored the list height on Back. A separate short-viewport check kept the card scrollable. On desktop, closing and reopening with Tab allowed the same player to be selected again. [Phone interaction](../media/mobile-profile.gif) · [Earned badge hovers](../media/earned-badges.gif)

The Studio test passed on a desktop viewport and on an emulated iPhone 17 Pro in landscape. It called the example board through the real client/server RemoteFunction, selected each tab, and checked the visible names, scores, rank order and active tab underline.

| Rank | Global | Friends |
| --- | --- | --- |
| 1 | Sample Juniper · 96 | Sample Rowan · 68 |
| 2 | Sample Ember · 82 | Sample Iris · 61 |
| 3 | Sample Sol · 75 | |

The sample provider assigns the same two fictional friends to every Studio tester. The built-in ordered-store adapter has a separate regression with two viewers and different friend lists. Production Roblox friend discovery and live DataStore availability are outside these fixture checks. [Watch the recorded interaction](../media/global-friends.gif)

## Repeat the Studio test

1. Insert [Roster.rbxm](../Roster.rbxm?raw=true) into `ReplicatedStorage` in a test place. Use the default Settings or copy the [hatch settings example](../examples/hatch-settings.luau) into the Settings child.
2. Put [rankings.server.luau](../examples/rankings.server.luau) in a Script in `ServerScriptService`.
3. Put [studio-rankings.client.luau](../tests/studio-rankings.client.luau) in a LocalScript in `StarterPlayerScripts`. Press **Play**. The test opens the list and leaves the Friends tab selected. Find `PASS · Roster Studio rankings` in Output.

## Check badge spacing and hints

In a fresh playtest, use [studio-badges.client.luau](../tests/studio-badges.client.luau) as the only Roster startup LocalScript. It verifies the 3-pixel gaps and bounds of three badges on a desktop row and the pinned mobile row. It repeats both layouts with `Tooltips = false`. All four cases passed in Studio.

Set `HOVER_SECONDS = 10` in the test for a manual pointer pass. Hover each badge, then repeat after hints are switched off. In the phone emulator a hold opened the badge hint, releasing the hold kept the list open, and a quick tap opened the card. With `Tooltips = false`, the same hold showed no hint. The [badge recording](../media/badge-tooltips.gif) shows two labels and a third badge with no hint.

## Run the offline checks

From the repository root, use [Lune 0.11.1](https://github.com/lune-org/lune/releases/tag/v0.11.1).

```sh
lune run tests/package.luau
lune run tests/rankings.luau
lune run tests/social-profile.luau
```

The package suite compares all four scripts in the model with their source and checks the desktop and mobile templates. It exercises the moving gradient, reduced motion, animation budget, badge crops and spacing after long or scaled names. The action tests cover button spans, touch targets, custom icon overrides and the bottom inset at several gap settings.

The rankings suite loads the shipped Luau module and exercises its server request handler with in-memory substitutes for Roblox services. It covers Global ordering, shared cached reads, Friends isolation between viewers, missing scores, ties among returned rows, partial scans with a limited read budget, and recovery after a source outage. Neither command requires a Roblox account or a live data store.

The biography suite uses controlled HTTP and filtering responses to test account IDs, absent bios, refresh limits, consent changes and cleanup. GitHub Actions is configured to run all three commands on pushes and pull requests. [View hosted test runs](https://github.com/Ggaming5005/Pennant/actions/workflows/checks.yml).

## Rebuild the Studio model

After editing the scripts in `src/`, run `lune run tools/build.luau` and repeat the package test. The build preserves both editable GUI templates and updates the module, the single editable Settings script, and the two internal presentation and bio modules.
