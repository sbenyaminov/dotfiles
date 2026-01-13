local wezterm = require("wezterm")
local config = require("config")
require("events")

-- Apply color scheme based on the WEZTERM_THEME environment variable
local themes = {
    nord = "Nord (Gogh)",
    onedark = "One Dark (Gogh)",
}
config.color_scheme = themes["nord"]

config.keys = {
    -- Shift+Enter to insert newline (for multi-line commands)
    {
        key = 'Enter',
        mods = 'SHIFT',
        action = wezterm.action.SendString '\x1b\r',
    },

    -- Alt+f to enter tmux copy mode and search upwards
    {
        key = 'f',
        mods = 'ALT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = '[', mods = 'NONE' },
            wezterm.action.SendKey { key = '?', mods = 'NONE' },
        },
    },

    -- Alt+t to create new tmux window
    {
        key = 't',
        mods = 'ALT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'c', mods = 'NONE' },
        },
    },

    -- Alt+w to close current tmux pane
    {
        key = 'w',
        mods = 'ALT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'x', mods = 'NONE' },
        },
    },

    -- Alt+[ for previous tmux window
    {
        key = '[',
        mods = 'ALT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'p', mods = 'NONE' },
        },
    },

    -- Alt+] for next tmux window
    {
        key = ']',
        mods = 'ALT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'n', mods = 'NONE' },
        },
    },
}

config.mouse_bindings = {
    -- Ctrl-click to open link
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

return config
