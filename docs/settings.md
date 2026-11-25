# Settings guide

In Studio's Explorer, open **ReplicatedStorage → Roster → Settings**. The client reads this ModuleScript when it calls `Roster.Start()`. Edit it in Edit mode and press Play to try the change.

Each code block below is a complete Settings module. To combine examples, copy their fields into one `return { ... }` table. A table passed to `Roster.Start({...})` overrides individual settings. Lists such as `Columns` and `Actions` are replaced in full.

### Profile banners and full-card frames

Profile places the avatar over the bottom edge of a jersey banner and keeps the identity text below the artwork. A transparent nine-slice frame wraps the full card and lets clicks through to the buttons. The [editable SVGs](../media/profile-source) and [exported PNGs](../media/pennant-icons.zip?raw=true) are included.

```luau
return {
    Preset = "Profile",
    ProfileFrame = {
        Image = 75286429427852,
        SliceCenter = Rect.new(22, 22, 74, 74), -- Inner rectangle in the 96×96 source.
        SliceScale = 0.7, -- Scales the border thickness.
    },
    StylePlayer = function(player)
        return {Card = {BannerImage = 131659092836215, Emblem = false}}
    end,
}
```

Use `ProfileFrame = true` on another preset or `false` to remove it. Per-player `Card.Frame` accepts the same values and an optional `Color` tint inside the frame table. Set `Card.HeaderLayout = "Compact"` and `Card.BannerImage = ""` for a short header. Inline emblems reserve a slot beside the identity when space permits. To permit a second line in a deliberately narrow design, set `Overflow = "Below"` on the emblem.

## Choose the layout and tabs

Here is a competitive scoreboard with the current server and a Friends tab. The phone layout gets its own title.

```luau
return {
    Preset = "Competitive",
    MobileTitle = "Scoreboard",
    Features = {Friends = true, Global = false},
}
```

| Preset | What the game supplies | What players see |
| --- | --- | --- |
| Omit `Preset` | Existing `leaderstats` and any configured ranking boards | Automatically discovered stats and available scopes |
| `Classic` | Existing `leaderstats` | The stock-style player list and profile card |
| `Simulator` | `Rebirths` and `Eggs` leaderstats, optional `Title`, `BestHatchImage` and `BestHatchOdds` player attributes | Hatch banner and stat tiles |
| `Competitive` | The player's team and the game's configured stat columns | Display name, @handle, team or custom title, and a row of labeled match stats |
| `Roleplay` | `Job`, `Department` and optional `Callsign` player attributes | An identity card with labeled details |
| `Profile` | Optional server bio provider | A framed social card with a cover, avatar, name, and About section when a filtered bio is available. [Set up biographies](profile.md) |

Every named preset starts with **Here**. Enable either ranked tab independently. Use `Features = {Rankings = true}` to allow both or `{Rankings = false}` for Here only. Ranked tabs need a board served by a server Script via `Roster.Serve()`. A Friends board backed by a custom `Read` callback also needs `ReadFriends` to return the viewer's friends. The [Studio server example](../examples/rankings.server.luau) supplies sample scores for both Global and Friends.

Layout adapts to the device. Use `Layout = "mobile"` or `"desktop"` to preview one explicitly. Set `MobileTitle = ""` to hide the title.

### Template icons

The art pack includes a signal flag, amber geode egg, blue chevron and civic shield. Classic, Simulator and Roleplay can display their emblem automatically. Competitive reserves the header for identity and Profile uses a banner. The chevron is available through `Roster.Icons.Competitive` for your own badge or action. Your own emblem, banner or featured hatch takes priority. Set `Card.Emblem = false` for one player or `TemplateIcons = false` for the whole list. [Download the original PNG pack](../media/pennant-icons.zip?raw=true)

```luau
return {
    Preset = "Roleplay",
    TemplateIcons = true,
}
```

To use artwork owned by your game, import the PNG under the user or group that owns the experience and copy the resulting **image asset ID**. Set `TemplateIcons = {Roleplay = imageId}` in Settings. To use a shared restricted asset, grant the destination experience permission and verify that it appears in a playtest. [Roblox asset import guide](https://create.roblox.com/docs/cloud/guides/usage-assets)

### Competitive match stats

The portrait sits in its own well. A thin divider separates the name and its earned pins from the handle and team. Return `Card = {ShowBadges = false}` from `StylePlayer` to hide the pins on that card, or `Card = {Finish = false}` to turn off the header's surface lighting.

The default card shows the player's display name, @handle and team, with Kills, Deaths and Assists below. Replace `Columns` to choose and order the match stats for your game. This example shows points and assists from existing leaderstats.

```luau
return {
    Preset = "Competitive",
    Columns = {
        {Id = "Points", Stat = "Points", Label = "Points"},
        {Id = "Assists", Stat = "Assists", Label = "Assists"},
    },
}
```

To show a numeric identifier, return `{Card = {Identity = "UserId"}}` from `StylePlayer`. The default identity line uses the player's @handle.

### MVP, VIP and role badges

`Roster.Badges` contains six opt-in graphic badges from one image atlas. The top row contains MVP, VIP and Creator. The bottom row contains Moderator, Champion and Founder. Each has a name tooltip and sits just after the displayed name. Your game decides who qualifies for each one. `Tooltips = false` keeps the images and hides the hints. `Features = {Badges = false}` hides player-list badges.

```luau
local art = require(script.Parent).Badges

return {
    StyleAttributes = {"IsMVP", "IsVIP"},
    StylePlayer = function(player)
        local badges = {}
        if player:GetAttribute("IsMVP") == true then table.insert(badges, art.MVP) end
        if player:GetAttribute("IsVIP") == true then table.insert(badges, art.VIP) end
        return {Badges = badges}
    end,
}
```

Clone a badge with `table.clone(art.VIP)` before changing its `Size`, `Position`, tint or tooltip. To host the badge sheet yourself, import the **768 × 512** atlas from the [PNG pack](../media/pennant-icons.zip?raw=true). Create your own set once with `Roster.MakeBadgeAtlas(yourImageId)` and use its six entries the same way. For a sheet with a different layout, your own badge definition can set `ImageRectOffset` and `ImageRectSize` in source pixels.

## Choose the stats

Supplying `Columns` sets the column order and replaces the preset columns. This example reads Coins from a leaderstat and Level from a player attribute. Widths are in pixels.

```luau
return {
    Columns = {
        {Id = "Coins", Stat = "Coins", Label = "Coins earned", Width = 100},
        {Id = "Level", Attribute = "Level", Width = 64},
    },
}
```

For an image that changes with a stat, see the [hatch example](../examples/hatch-settings.luau). It reads an image ID from each player's attributes and prints the odds alongside it. Set `IconSize` on a column to size its image.

## Style the name, badge and profile card

Names can animate with no badges. To add badges, return a `Badges` list from `StylePlayer`. Right-side badges start 3 pixels after the displayed name. Set `NameBadgeGap` in Settings to adjust the spacing. `MaxBadges` defaults to 4 and can be set up to 8 when the row has room.

Each badge can have an optional `Tooltip` string, such as `{Text = "ADM", Position = "Right", Tooltip = "Admin badge"}`. Hover a labeled badge or hold it briefly on touch. A quick tap opens the player card. Leave the string out for a badge without a hint. Set **`Tooltips = false`** at the top level of Settings to turn off every badge hint. The badge artwork remains visible.

This example gives guides a wave in the list, a star after their name and a larger star behind their profile details. Other players keep the preset's appearance. Set the boolean player attribute `IsGuide` in your game. Listing it in `StyleAttributes` refreshes the style when it changes.

```luau
return {
    Preset = "Roleplay",
    StyleAttributes = {"IsGuide"},
    StylePlayer = function(player)
        if player:GetAttribute("IsGuide") ~= true then return {} end
        local gold = Color3.fromRGB(255, 205, 111)
        return {
            Title = "Guide",
            NameTag = {
                Font = Enum.Font.BuilderSansBold,
                Color = gold,
                Effect = {
                    Motion = "Wave", Amplitude = 2,
                    ColorMode = "Cycle", Colors = {gold, Color3.fromRGB(255, 245, 219)},
                },
            },
            Badges = {{Emoji = "✦", Position = "Right", Size = 16, Color = gold}},
            Card = {
                BannerColor = Color3.fromRGB(46, 37, 52),
                AvatarRingColor = gold,
                NameTag = {Effect = false},
                Emblem = {Emoji = "✦", Position = "Behind", Align = "Right", Size = 72, Transparency = 0.82},
            },
        }
    end,
}
```

For a one-line name effect, use `Effect = "Wave"`, `"Glitch"`, `"Cycle"`, `"Rainbow"`, `"Shimmer"`, `"Gradient"` or `"MovingGradient"`. Gradient is static. The card inherits the row's styling. Its `NameTag = {Effect = false}` keeps the card name still.

Badges and card emblems accept `Image` for your Roblox image asset ID or `Emoji` for a literal character. Set `Position` to `"Left"`, `"Right"` or `"Behind"`. A large image behind the text works well with high `Transparency`, where 1 is invisible. For artwork across the whole banner, set `Card.BannerImage`. For shared dimensions, set `IconSizes = {Badge = 16, Stat = 18, Avatar = 48, Featured = 40, Tile = 18}`.

## Move a palette across a name

`Effect = "MovingGradient"` sends an ice-blue, lilac and violet band across the letters. This complete Settings example gives team members their own colors and sends the band toward the left. It also applies to the open profile card.

```luau
return {
    StylePlayer = function(player)
        if not player.Team then return {} end
        local teamColor = player.Team.TeamColor.Color
        return {
            NameTag = {
                Font = Enum.Font.BuilderSansBold,
                Effect = {
                    Preset = "MovingGradient",
                    Colors = {teamColor, Color3.fromRGB(242, 246, 255), teamColor:Lerp(Color3.new(1, 1, 1), 0.4)},
                    Direction = "Left",
                    Speed = 0.65,
                    BandWidth = 0.85,
                },
            },
        }
    end,
}
```

`BandWidth = 1` stretches one palette across the name. Set it to `0.5` to fit two passes across the same space. The colors mirror at the edges so the last color flows back through the palette. Use `Direction = "Up"` or `"Down"` to move the color through the height of the letters. `Speed = 0` keeps the gradient still. Roblox's Reduce Motion preference and the shared animation budget also produce a static gradient.

For a ripple with the same colors, set `Motion = "Wave"` and `ColorMode = "MovingGradient"` in the effect table. Glitch can use the same color mode. [Moving gradient options](api.md#moving-gradient-options)

## Arrange the profile buttons

On Competitive cards, supply `OnLoadout(target, viewer)` to open equipment and `OnHighlights(target, viewer)` to open your game's match highlights. Loadout uses two of three columns, the native **Inspect** avatar action occupies one, and **View highlights** uses a full row. These actions use a blue, slate and plum finish respectively. Missing game callbacks are skipped. A touch layout keeps at least 44 pixels of button height and fewer columns fit on a narrow screen. The remaining native social actions depend on the selected player.

To use this finish on another preset, set `ActionGrid = {Finish = "Competitive"}`. Set `Finish = false` in a Competitive action grid to use plain button surfaces. `ActionGrid.Gap` sets both the row spacing and the space below the final button. A definition's `Color` changes its surface color and `Icon` replaces its artwork. The backpack, magnifier and replay clapper are available as `Roster.ActionIcons.Loadout`, `.Inspect` and `.Highlights`. The icon and caption center together. [Download the original PNGs and editable button SVGs](../media/pennant-icons.zip?raw=true)

This puts View outfit on its own row and gives the friend action twice the width of Block when all three columns fit.

```luau
return {
    ActionGrid = {Columns = 3, MinCellWidth = 80, RowHeight = 44, Gap = 4},
    Actions = {
        {Id = "Avatar", Label = "View outfit", Emoji = "👕", IconPosition = "Right", IconSize = 18, Span = "Full"},
        {Id = "Friend", Span = 2},
        {Id = "Block", Span = 1},
    },
}
```

Buttons follow array order. The grid repacks visible actions for the available width and player. Use `BreakBefore = true` to start a row early. To vary the actions by player, return `Card.Actions` from `StylePlayer`. A custom action takes a unique `Id`, a `Label` and an `OnActivated(target)` callback. The shipped Settings module includes a working **Show team** example.

Use `Span = "Wide"` when a button should leave one column for its neighbor as the layout adapts. A numeric span reserves a fixed number of columns, capped at the number that fit.

Button artwork uses `Icon` or `Emoji`. `IconPosition` accepts `"Left"`, `"Right"`, `"Top"` or `"Behind"`. For a watermark, try `IconPosition = "Behind", IconAlign = "Right", IconSize = 56, IconTransparency = 0.82`.

## Choose how the list opens and closes

```luau
return {
    Motion = {
        Open = {Preset = "SlideRight", Duration = 0.30},
        Close = "Fade",
    },
}
```

| Motion | Behavior |
| --- | --- |
| `Stock` | Default. Desktop springs in from the right. On phones the centered panel scales into place. |
| `Instant`, `Fade` | Show immediately or change opacity. |
| `SlideLeft`, `SlideRight`, `SlideTop`, `SlideBottom` | Enter from that screen edge or exit toward it. |
| `Slide` | Move a short distance. Set `Direction` to `"Left"`, `"Right"`, `"Up"` or `"Down"` and `Distance` in pixels. |
| `Pop`, `CenterPop`, `CenterZoom` | Scale and fade. CenterPop grows from the center of the visible panel. CenterZoom starts enlarged. |
| `CartoonBounce`, `FloatUp` | Overshoot and settle, or drift upward while fading. |

## Set the animation budget

The defaults are `Effects = {FPS = 24, MaxAnimatedNames = 6, MaxGlyphs = 14}`. For a busy phone-first game, try `{FPS = 16, MaxAnimatedNames = 3, MaxGlyphs = 10}`. The budget applies to visible names. The open profile gets priority and the name animation loop sleeps when the list closes. Players who enable Roblox's Reduce Motion setting get static names and instant panel transitions. To disable name effects for everyone while keeping your fonts and colors, set `Features = {NameEffects = false}`.
