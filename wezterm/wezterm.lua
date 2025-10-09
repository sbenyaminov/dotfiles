local wezterm = require("wezterm")
local config = require("config")
require("events")

-- Apply color scheme based on the WEZTERM_THEME environment variable
local themes = {
    nord = "Nord (Gogh)",
    onedark = "One Dark (Gogh)",
}
config.color_scheme = themes["nord"]

local function remap_cmd_to_ctrl()
    local keys = {}

    -- Loop through printable characters - remap CMD to CTRL
    for i = 32, 126 do
        local key = string.char(i)

        -- Keep native Cmd+C and Cmd+V behavior for copy/paste
        -- if key == "c" then
        --     table.insert(keys, {
        --         key = "c",
        --         mods = "CMD",
        --         action = wezterm.action {
        --             Multiple = {
        --                 wezterm.action.CopyTo("Clipboard"),
        --                 wezterm.action.SendKey{ key = 'c', mods = 'CTRL' },
        --             }
        --         }
        --     })
        if key == "v" then
            table.insert(keys, {
                key = "v",
                mods = "CMD",
                action = wezterm.action.PasteFrom("Clipboard"),
            })
        else
            table.insert(keys, {
                key = key,
                mods = "CMD",
                action = wezterm.action.SendKey { key = key, mods = "CTRL" },
            })
        end
    end

    -- Also remap CMD+SHIFT to CTRL+SHIFT for all printable characters
    for i = 32, 126 do
        local key = string.char(i)
        table.insert(keys, {
            key = key,
            mods = "CMD|SHIFT",
            action = wezterm.action.SendKey { key = key, mods = "CTRL|SHIFT" },
        })
    end
    -- Add common non-printable keys
    local special_keys = {
        "Shift", "Tab", "Enter", "Escape", "Backspace",
        "LeftArrow", "RightArrow", "UpArrow", "DownArrow",
        "PageUp", "PageDown", "Home", "End",
        "Insert", "Delete", "Space"
    }

    for _, key in ipairs(special_keys) do
        table.insert(keys, {
            key = key,
            mods = "CMD",
            action = wezterm.action.SendKey { key = key, mods = "CTRL" },
        })
    end

    table.insert(keys, {
        key = 'LeftArrow',
        mods = 'OPT',
        action = wezterm.action.SendKey {
            key = 'b',
            mods = 'ALT',
        },
    })
    table.insert(keys, {
        key = 'RightArrow',
        mods = 'OPT',
        action = wezterm.action.SendKey {
            key = 'f',
            mods = 'ALT',
        },
    })

    -- Shift+Enter to insert newline (for multi-line commands)
    table.insert(keys, {
        key = 'Enter',
        mods = 'SHIFT',
        action = wezterm.action.SendString '\x1b\r',
    })

    -- Cmd+f to enter tmux copy mode and search upwards
    table.insert(keys, {
        key = 'f',
        mods = 'CMD',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = '[', mods = 'NONE' },
            wezterm.action.SendKey { key = '?', mods = 'NONE' },
        },
    })

    -- Cmd+r to search command history with fzf
    table.insert(keys, {
        key = 'r',
        mods = 'CMD',
        action = wezterm.action.SendString '\x12',
    })

    -- Cmd+Shift+[ (Cmd+{) to move to previous tmux window (Ctrl+a then p)
    table.insert(keys, {
        key = '{',
        mods = 'CMD|SHIFT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'p', mods = 'NONE' },
        },
    })

    -- Cmd+Shift+] (Cmd+}) to move to next tmux window (Ctrl+a then n)
    table.insert(keys, {
        key = '}',
        mods = 'CMD|SHIFT',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'n', mods = 'NONE' },
        },
    })

    -- Cmd+t (Ctrl+t) to create new tmux window and prompt for name (Ctrl+a then c, then Ctrl+a ,)
    table.insert(keys, {
        key = 't',
        mods = 'CMD',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'c', mods = 'NONE' },
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = ',', mods = 'NONE' },
        },
    })

    -- Cmd+w (Ctrl+w) to close current tmux pane (Ctrl+a then x)
    table.insert(keys, {
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.Multiple {
            wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
            wezterm.action.SendKey { key = 'x', mods = 'NONE' },
        },
    })

    return keys
end

config.keys = remap_cmd_to_ctrl()
config.mouse_bindings = {
    -- CMD-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'SHIFT',
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}

return config
