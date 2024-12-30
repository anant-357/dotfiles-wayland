export def main [] {
    let gruvbox_fg = "#ebdbb2"
let gruvbox_green = "#b8bb26"
let gruvbox_blue = "#83a598"
let gruvbox_yellow = "#fabd2f"
let gruvbox_purple = "#d3869b"
let gruvbox_gray = "#928374"
let gruvbox_bg = "#28282800"
let gruvbox_red = "#fb4934"
let gruvbox_aqua = "#8ec07c"
let gruvbox_orange = "#fe8019"

let gruvbox_green_bold = { fg: $gruvbox_green bg: $gruvbox_bg attr: b }
let gruvbox_purple_bold = { fg: $gruvbox_purple bg: $gruvbox_bg attr: b }
let gruvbox_red_bold = { fg: $gruvbox_red bg: $gruvbox_bg attr: b }
let gruvbox_yellow_bold = { fg: $gruvbox_yellow bg: $gruvbox_bg attr: b }
let gruvbox_aqua_bold = { fg: $gruvbox_aqua bg: $gruvbox_bg attr: b }
let gruvbox_blue_bold = { fg: $gruvbox_blue bg: $gruvbox_bg attr: b }
let gruvbox_gray_bold = { fg: $gruvbox_gray bg: $gruvbox_bg attr: b }

    return {
    foreground: $gruvbox_fg
    background: $gruvbox_bg
    cursor: $gruvbox_fg
    
    separator: $gruvbox_fg
    leading_trailing_space_bg: { attr: n }
    header: $gruvbox_gray_bold
    empty: $gruvbox_blue
    bool: $gruvbox_fg
    int: $gruvbox_fg
    filesize: $gruvbox_fg
    duration: $gruvbox_fg
    date: $gruvbox_fg
    range: $gruvbox_fg
    float: $gruvbox_fg
    string: $gruvbox_fg
    nothing: $gruvbox_fg
    binary: $gruvbox_fg
    cellpath: $gruvbox_fg
    row_index: $gruvbox_gray
    record: $gruvbox_fg
    list: $gruvbox_fg
    block: $gruvbox_fg
    hints: $gruvbox_gray

    shape_garbage: $gruvbox_red_bold
    shape_binary: $gruvbox_purple_bold
    shape_bool: $gruvbox_aqua
    shape_int: $gruvbox_purple_bold
    shape_float: $gruvbox_purple_bold
    shape_range: $gruvbox_yellow_bold
    shape_internalcall: $gruvbox_aqua_bold
    shape_external: $gruvbox_aqua
    shape_externalarg: $gruvbox_green_bold
    shape_literal: $gruvbox_aqua
    shape_operator: $gruvbox_yellow
    shape_signature: $gruvbox_green_bold
    shape_string: $gruvbox_green
    shape_string_interpolation: $gruvbox_aqua_bold
    shape_datetime: $gruvbox_aqua_bold
    shape_list: $gruvbox_aqua_bold
    shape_table: $gruvbox_blue_bold
    shape_record: $gruvbox_aqua_bold
    shape_block: $gruvbox_blue_bold
    shape_filepath: $gruvbox_blue
    shape_globpattern: $gruvbox_aqua_bold
    shape_variable: $gruvbox_purple
    shape_flag: $gruvbox_blue_bold
    shape_custom: $gruvbox_green
    shape_nothing: $gruvbox_aqua
  }
}

# Update the Nushell configuration
export def --env "set color_config" [] {
    $env.config.color_config = (main)
}

# Update terminal colors
export def "update terminal" [] {
    let theme = (main)

    # Set terminal colors
    let osc_screen_foreground_color = '10;'
    let osc_screen_background_color = '11;'
    let osc_cursor_color = '12;'
        
    $"
    (ansi -o $osc_screen_foreground_color)($theme.foreground)(char bel)
    (ansi -o $osc_screen_background_color)($theme.background)(char bel)
    (ansi -o $osc_cursor_color)($theme.cursor)(char bel)
    "
    # Line breaks above are just for source readability
    # but create extra whitespace when activating. Collapse
    # to one line and print with no-newline
    | str replace --all "\n" ''
    | print -n $"($in)\r"
}

export module activate {
    export-env {
        set color_config
        update terminal
    }
}

# Activate the theme when sourced
use activate
