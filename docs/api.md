# Roster API

Require `game:GetService("ReplicatedStorage"):WaitForChild("Roster")`. Start the UI on each client. Start the ranking service on the server if the game offers ranked boards. [Installation](../README.md) · [Settings and visual options](settings.md)

## Client

| Call | Result |
| --- | --- |
| `Roster.Start(overrides?, fallbackOptions?)` | Mounts the player list and returns its controller. A second call in the same client session returns the same controller. Concurrent starts share the first mount. |
| `controller:SetOpen(true)` or `controller:SetOpen(false)` | Opens or closes the custom roster. Use this from a game menu’s `GuiButton.Activated` handler. Closing also dismisses the selected player card. |
| `controller:SelectPlayer(player)` | Opens **Here**, scrolls to the live player when necessary and selects their card. Returns `true` on success. Returns `false` for an unavailable player, a destroyed controller or disabled cards. |
| `controller:SelectTab(id, scope?)` | Returns `true` if the selection is available. Use `"Here"` for the live list or a board ID with `"Global"` or `"Friends"`. With a board ID and no scope, it prefers Global when enabled. Selecting a tab while closed takes effect on the next open. |
| `controller:Destroy()` | Releases the UI, input bindings and subscriptions, and restores the stock list setting the controller took over. A subsequent `Start` creates a new controller. |

**Configuration precedence.** Explicit `Start` overrides take priority over `Roster.Settings`, and Settings take priority over optional `fallbackOptions`. Presets and built-in defaults fill omitted fields. Nested named options such as `ActionGrid.Gap` or `Motion.Close` inherit individually. Ordered arrays such as `Columns`, `Actions` and `Tabs` replace the earlier list in full, including an explicit empty array. Callbacks replace earlier callbacks. Settings are read at startup. To test edits to a Settings ModuleScript, save it in Edit mode and start a new playtest.

**Desktop and touch.** The desktop replacement normally opens on keyboard startup and toggles with Tab. The mobile roster starts closed by default. On the tested touch client Roblox’s native overflow **⋯ → Leaderboard** opens Roblox’s built-in list. Connect an existing game menu button to `controller:SetOpen(true)` to open the custom list on touch. The module adds no floating opener. `StartOpen` controls the initial custom panel state, and `MobileTitle` changes its heading. [Client startup example](../examples/start.client.luau)

## Live data and styling

**Competitive match cards.** `Columns` supplies the ordered match stats. The preset starts with Kills, Deaths and Assists. The header shows the player's display name, @handle and team. Return `Title` from `StylePlayer` to supply a custom title, or set `Card.Identity = "UserId"` to show the numeric player ID. [Settings example](settings.md#competitive-match-stats)

**Bundled art.** `Roster.Icons` exposes the four preset card image URIs by preset name. `Roster.Badges` exposes immutable sprite specs for `MVP`, `VIP`, `Creator`, `Moderator`, `Champion` and `Founder`. Pass them in the player's ordered `Badges` array. To point all six at your own upload of the same atlas, call `Roster.MakeBadgeAtlas(imageId)` once. It accepts a numeric image ID or an image URI. Each entry includes its image, cell offset, pixel size, position and tooltip. `TemplateIcons` controls preset card art separately. [Settings and source art](settings.md#template-icons)

**Here** reads the current server’s players. Without `Columns`, the roster discovers public `IntValue`, `NumberValue`, `StringValue` and `BoolValue` children of `leaderstats`. It follows their values and handles players or stats added after startup. `StatsFolder` selects another folder name.

| Setting | Contract |
| --- | --- |
| `Columns` | Ordered entries with a unique string `Id` and optional `Label`, `Stat`, `Attribute`, `Width` and `IconSize`. `Attribute` reads a Player attribute. Otherwise `Stat` or the column ID names a value in the stats folder. `SortBy` can select an initial column ID. |
| Column callbacks | `Format(value, player)` returns display text. `Image(value, player)` returns an asset URI or numeric asset ID. `Color(value, player)` returns a `Color3`. The underlying value drives sorting. Missing values display as an em dash. |
| `StylePlayer(player)` | Returns a per-player table. `NameTag` sets a font or font face, color, stroke and optional effect. `Badges` adds ordered images or emoji. `Title` and `Card` customize the selected card. Add any extra attributes the callback reads to `StyleAttributes` so their changes repaint the UI. |
| `Card` | Supports banner art/tint, avatar ring, featured image and text, an optional emblem, and `Tiles` entries with `Label`, `Text`, optional `Image`, `Color` and `IconSize`. `Card.NameTag` overrides individual name settings. `Card.NameTag = false` restores the native card name. |
| `Features` | `Cards`, `CardStats`, `Badges`, `NameEffects`, `ItemImages`, `AvatarAction`, `SocialActions` and `Trade` control individual features. `Global` and `Friends` control ranked scopes. `Rankings = false` hides both. |
| `Tabs` | Optional ordered client board entries with `Id`, `Label`, `ColumnLabel`, `Format(score)`, `Friends` and `ShowProfiles`. An omitted `Tabs` uses the server catalog. Enable Friends on an explicitly configured client tab only when the server board supports that scope. |

`Classic`, `Simulator`, `Competitive` and `Roleplay` presets start with **Here**. To show both ranked scopes for an explicit preset, set `Features = {Rankings = true}` and serve compatible boards. With no preset, available server boards are discovered by default. The hatch example includes a rare-item column and enables both ranking scopes. [Hatch settings example](../examples/hatch-settings.luau)

### Moving gradient options

Return `NameTag = {Effect = "MovingGradient"}` from `StylePlayer` for the default palette. Use an effect table with `Preset = "MovingGradient"` to customize it. A card inherits the effect or can override it through `Card.NameTag.Effect`. [Complete Settings example](settings.md#move-a-palette-across-a-name)

| Effect field | Behavior |
| --- | --- |
| `Colors` | Up to six ordered `Color3` values or a `ColorSequence`. The default palette runs from ice blue through lilac to violet. Longer sequences are sampled at six stops. |
| `Direction` | `"Right"` (default), `"Left"`, `"Up"` or `"Down"`. The direction selects the gradient axis. |
| `BandWidth` | Fraction of the displayed name width for horizontal travel or its height for vertical travel, from 0.25 to 1. Default 1. |
| `Speed` | Palette lengths traveled per second, from 0 to 4. Default 1. At speed 1 a complete mirrored loop takes two seconds. |
| `Phase` | Initial travel in palette lengths, from −100 to 100. At 1 the colors start one band ahead. At 2 they repeat. |
| `Motion` | Combine `"Wave"` or `"Glitch"` with `ColorMode = "MovingGradient"`. Horizontal waves can color individual letters. Vertical waves move the whole line together. |

On current clients the whole-name renderer uses a single native mirrored `UIGradient` for its lettering. Animation ticks change the offset and reuse its palette. Roblox Reduce Motion, `Speed = 0` and the animation cap preserve the static colors. Clients without mirrored tile support use an ordinary gradient. [Roblox gradient options](https://create.roblox.com/docs/ui/appearance-modifiers#tile-mode)

## Card actions

For the Competitive preset, `OnLoadout(targetPlayer, viewer)` and `OnHighlights(targetPlayer, viewer)` connect the two game-specific actions. Both apply to self and other live players. **Inspect** uses the built-in avatar inspector. `Roster.ActionIcons` contains the original Loadout backpack, Inspect magnifier and Highlights replay clapper asset URIs. Set an action's `Icon` to replace its default or `Icon = false` to show only the caption. [Appearance, grouping and spans](settings.md#arrange-the-profile-buttons)

Put ordered action IDs or definitions in `Actions`. A player’s `Card.Actions` can provide a different list. **Avatar** opens Roblox’s avatar inspector. **Friend** and **Block** invoke the appropriate native prompts for an eligible other player in the server. **Trade** requires the game’s `OnTrade(targetPlayer)`. **Spectate** and **ShowID** take `OnSpectate(targetPlayer, viewer)` and `OnShowID(targetPlayer, viewer)`.

A custom definition takes `Id`, optional `Label`, and `OnActivated(targetPlayer, viewer)`. `Audience` accepts `"Self"`, `"Other"` or `"Both"`. Custom actions default to other players. `When(viewer, targetPlayer)` must return `true` for the action to appear. The predicate receives the **viewer first** and the action callback receives the **target first**. Use `Span = "Full"`, a numeric `Span`, or `BreakBefore = true` to arrange the buttons. Keep trades, purchases and other state changes in the game’s server-side validation flow.

## Server rankings

For the independent biography service, see [ServeProfiles, consent and refresh](profile.md). Profile cards work with the ranking service turned off.

| Call | Result |
| --- | --- |
| `Roster.Serve()` | Reads `Boards` from `Roster.Settings`, publishes a client catalog and mounts the ranking service. Call once from a Script in `ServerScriptService`. |
| `Roster.Serve({Boards = {...}})` | Uses the supplied server configuration in full. Keep private providers or server-only dependencies here. Repeated calls share the running service. |
| `service:Destroy()` | Removes the service endpoint and published catalog and releases active readers and subscriptions. A later `Serve` can start the service again. |

Each board uses a unique `Id` of 1–64 bytes. `"Here"` is reserved. Optional `Label` and `ColumnLabel` control the visible names. `Limit` defaults to 25 and accepts integers from 1 to 100. Higher scores rank first unless `Ascending = true`. `Min` and `Max` are inclusive. Equal scores sort by ascending user ID.

| Score source | Configuration |
| --- | --- |
| Existing ordered data store | Supply `Store` and optional `Scope` (default `"global"`). Roster reads the ordered index. Your game writes scores. Bounds for an ordered store must be integers. Keys default to decimal Roblox user IDs. |
| Custom keys | `KeyToUserId(key)` decodes a store key. Supply the inverse `UserIdToKey(userId)` for individual Friends score reads, or supply `ReadFriends`. |
| Custom provider | `Read(limit)` returns an array of `{userId = number, score = number, name = string?}` records. Supply the best candidates for the board. Roster checks IDs and finite scores, applies bounds, deduplicates, sorts, assigns ranks and trims the result. |
| Friends | An ordered-store board can read scores for the viewer and connections Roblox identifies as having played the experience. A custom provider supplies `ReadFriends(viewer, limit)` returning the same record shape for that viewer’s eligible cohort. Include eligible scores from outside the global cutoff. `Friends = false` offers the board as Global only. |

For fictional fixtures use `ShowProfiles = false` and provide display names. The Studio example ranks five sample players from memory and displays the global top three. Sample Rowan scores 68, placing fourth overall and first among the two sample friends. For a production ordered index, provide `Store` in your server board definition and let Roster read each account’s score. [Ranking provider example](../examples/rankings.server.luau)
