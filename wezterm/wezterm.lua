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

    -- Loop through printable characters
    for i = 32, 126 do
        local key = string.char(i)

        -- Keep native Cmd+C and Cmd+V behavior for copy/paste
        if key == "c" then
            table.insert(keys, {
                key = "c",
                mods = "CMD",
                action = wezterm.action {
                    Multiple = {
                        wezterm.action.CopyTo("Clipboard"),
                        wezterm.action.SendKey{ key = 'c', mods = 'CTRL' },
                    }
                }
            })
        elseif key == "v" then
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
    -- Add common non-printable keys
    local special_keys = {
        "Tab", "Enter", "Escape", "Backspace",
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
    return keys
end

config.keys = remap_cmd_to_ctrl()
return config
