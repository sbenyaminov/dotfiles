local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config = {
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    default_cursor_style = "SteadyBar",
    automatically_reload_config = true,
    window_close_confirmation = "NeverPrompt",
    adjust_window_size_when_changing_font_size = false,
    window_decorations = "RESIZE",
    check_for_updates = false,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = false,
    font_size = 14,
    font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
    enable_tab_bar = true,
    scrollback_lines = 10000,
    enable_scroll_bar = true,
    default_prog = { "wsl.exe", "--distribution", "Ubuntu-22.04", "--exec", "/bin/zsh", "-l", "-c", "tmux attach -t main 2>/dev/null || tmux new -s main" },
    window_padding = {
        left = 3,
        right = 3,
        top = 0,
        bottom = 0,
    },
    background = {
        {
            source = {
                Color = "#282c35",
            },
            width = "100%",
            height = "100%",
            opacity = 1,
        },
    },
    hyperlink_rules = {
        -- Matches: a URL in parens: (URL)
        {
            regex = "\\((\\w+://\\S+)\\)",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in brackets: [URL]
        {
            regex = "\\[(\\w+://\\S+)\\]",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in curly braces: {URL}
        {
            regex = "\\{(\\w+://\\S+)\\}",
            format = "$1",
            highlight = 1,
        },
        -- Matches: a URL in angle brackets: <URL>
        {
            regex = "<(\\w+://\\S+)>",
            format = "$1",
            highlight = 1,
        },
        -- Then handle URLs not wrapped in brackets
        {
            -- Before
            --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
            --format = '$0',
            -- After
            regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
            format = "$1",
            highlight = 1,
        },
        -- implicit mailto link
        {
            regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
            format = "mailto:$0",
        },
    },
}
return config
