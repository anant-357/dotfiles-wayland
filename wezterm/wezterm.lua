local wezterm = require("wezterm")

local function font_with_fallback(name, params)
    local names = {name, "Symbols Nerd Font Mono", "azuki_font"}
    return wezterm.font_with_fallback(names, params)
end

local font_name = "Fira Code SemiBold"


local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick

local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick

function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then 
      return {
	{ Background = { Color = '#282a36' } },
        { Foreground = { Color = '#e8e8e2' } },
        { Text = '  ' },
      }
    else
      return {
        { Background = { Color = '#282a36' } },
        { Foreground = { Color = '#c8c8c2' } },
        { Text = '' },
      }
    end
  end
)




return {
	tab_max_width = 20,
    front_end = "OpenGL",
 
    -- Font config
    font = font_with_fallback(font_name),
    font_rules = {{
        italic = true,
        font = font_with_fallback(font_name, {
            italic = true
        })
    }, {
        italic = true,
        intensity = "Bold",
        font = font_with_fallback(font_name, {
            italic = true,
            bold = true
        })
    }, {
        intensity = "Bold",
        font = font_with_fallback(font_name, {
            bold = true
        })
    }},
    warn_about_missing_glyphs = false,
    font_size = 11,
    harfbuzz_features = {"zero", "ss01", "cv05"},

    -- Cursor style
    default_cursor_style = "BlinkingUnderline",
    animation_fps = 1,
    underline_thickness = 1,
    cursor_blink_rate = 800,
    custom_block_glyphs = false,
    -- X11
    enable_wayland = true,
    dpi = 96.0,
    freetype_load_target = "HorizontalLcd",
    
    -- Keybinds
    disable_default_key_bindings = true,
    keys = {{
        key = [[\]],
        mods = "CTRL|ALT",
        action = wezterm.action({
            SplitHorizontal = {
                domain = "CurrentPaneDomain"
            }
        })
    }, {
        key = [[\]],
        mods = "CTRL",
        action = wezterm.action({
            SplitVertical = {
                domain = "CurrentPaneDomain"
            }
        })
    }, {
        key = "q",
        mods = "CTRL",
        action = wezterm.action({
            CloseCurrentPane = {
                confirm = false
            }
        })
    }, {
        key = "h",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            ActivatePaneDirection = "Left"
        })
    }, {
        key = "l",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            ActivatePaneDirection = "Right"
        })
    }, {
        key = "k",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            ActivatePaneDirection = "Up"
        })
    }, {
        key = "j",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            ActivatePaneDirection = "Down"
        })
    }, {
        key = "h",
        mods = "CTRL|SHIFT|ALT",
        action = wezterm.action({
            AdjustPaneSize = {"Left", 1}
        })
    }, {
        key = "l",
        mods = "CTRL|SHIFT|ALT",
        action = wezterm.action({
            AdjustPaneSize = {"Right", 1}
        })
    }, {
        key = "k",
        mods = "CTRL|SHIFT|ALT",
        action = wezterm.action({
            AdjustPaneSize = {"Up", 1}
        })
    }, {
        key = "j",
        mods = "CTRL|SHIFT|ALT",
        action = wezterm.action({
            AdjustPaneSize = {"Down", 1}
        })
    }, { -- browser-like bindings for tabbing
        key = "t",
        mods = "CTRL",
        action = wezterm.action({
            SpawnTab = "CurrentPaneDomain"
        })
    }, {
        key = "Tab",
        mods = "CTRL",
        action = wezterm.action({
            ActivateTabRelative = 1
        })
    }, {
        key = "Tab",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            ActivateTabRelative = -1
        })
    }, -- standard copy/paste bindings
    {
        key = "v",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            PasteFrom = "Clipboard"
        })
    },
	{
		key="+",
		mods = "CTRL",
		action = wezterm.action.IncreaseFontSize
	},
	{
		key="-",
		mods = "CTRL",
		action = wezterm.action.DecreaseFontSize
	}
	, {

        key = "c",
        mods = "CTRL|SHIFT",
        action = wezterm.action({
            CopyTo = "ClipboardAndPrimarySelection"
        })
    }},

color_scheme='Gruvbox Dark (Gogh)',

    -- Padding
    window_padding = {
        left = 12,
        right = 4,
        top = 4,
        bottom = 0
    },

    -- Tab Bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    show_tab_index_in_tab_bar = false,
    tab_bar_at_bottom = true,
    use_fancy_tab_bar = false,
    -- General
    automatically_reload_config = true,
    inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 1.0
    },
    window_background_opacity = 1.0,
    macos_window_background_blur = 20,
    window_close_confirmation = "NeverPrompt",
    window_frame = {
        active_titlebar_bg = "#090909",
        font = font_with_fallback(font_name, {
            bold = true
        })
    },
    colors = {
    tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#0b0022',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#2b2042',
      -- The color of the text for the tab
      fg_color = '#c0c0c0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },


    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
},
    show_new_tab_button_in_tab_bar = false,

}
