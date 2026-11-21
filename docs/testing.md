# Verification

## Recorded Studio result

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
```

Both suites passed locally. The package suite compares the two scripts inside the model against the source files, checks the editable UI templates, compiles the examples and verifies the sample server stays inactive outside Studio.

The rankings suite loads the shipped Luau module and exercises its server request handler with in-memory substitutes for Roblox services. It covers Global ordering, shared cached reads, Friends isolation between viewers, missing scores, ties among returned rows, partial scans with a limited read budget, and recovery after a source outage. Neither command requires a Roblox account or a live data store.

GitHub Actions runs both commands on pushes and pull requests. [View test runs](https://github.com/Ggaming5005/Pennant/actions/workflows/checks.yml).

## Rebuild the Studio model

After editing the scripts in `src/`, run `lune run tools/build.luau` and repeat the package test. The build keeps the editable GUI templates from the checked-in model and updates its two scripts.
