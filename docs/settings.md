# Settings guide

In Studio's Explorer, open **ReplicatedStorage → Roster → Settings**. The client reads this ModuleScript when it calls `Roster.Start()`. Edit it in Edit mode and press Play to try the change.

Each code block below is a complete Settings module. To combine examples, copy their fields into one `return { ... }` table. A table passed to `Roster.Start({...})` overrides individual settings. Lists such as `Columns` and `Actions` are replaced in full.

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
| `Competitive` | `Kills`, `Deaths` and `Assists` leaderstats, optional team | Team-colored card and match stats |
| `Roleplay` | `Job`, `Department` and optional `Callsign` player attributes | An identity card with labeled details |

Every named preset starts with **Here**. Enable either ranked tab independently. Use `Features = {Rankings = true}` to allow both or `{Rankings = false}` for Here only. Ranked tabs need a board served by a server Script via `Roster.Serve()`. A Friends board backed by a custom `Read` callback also needs `ReadFriends` to return the viewer's friends. The [server example](../examples/rankings.server.luau) provides a working Global-only board.

Layout adapts to the device. Use `Layout = "mobile"` or `"desktop"` to preview one explicitly. Set `MobileTitle = ""` to hide the title.

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

For a one-line name effect, use `Effect = "Wave"`, `"Glitch"`, `"Cycle"`, `"Rainbow"`, `"Shimmer"` or `"Gradient"`. Gradient is static. The card inherits the row's font and color. Its `NameTag = {Effect = false}` keeps the card name still.

Badges and card emblems accept `Image` for your Roblox image asset ID or `Emoji` for a literal character. Set `Position` to `"Left"`, `"Right"` or `"Behind"`. A large image behind the text works well with high `Transparency`, where 1 is invisible. For artwork across the whole banner, set `Card.BannerImage`. For shared dimensions, set `IconSizes = {Badge = 16, Stat = 18, Avatar = 48, Featured = 40, Tile = 18}`.

## Arrange the profile buttons

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
