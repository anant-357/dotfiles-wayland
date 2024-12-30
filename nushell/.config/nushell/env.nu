def create_left_prompt [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi reset)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_right_prompt [] {
    use std
    let git_current_ref = $"(git rev-parse --abbrev-ref HEAD e> (std null-device))"
    let git_segment = if ($git_current_ref != "") {
        $"(ansi yellow)󰘬 ($git_current_ref) " 
    }

    $git_segment
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| ":: " }

$env.TRANSIENT_PROMPT_COMMAND = {|| "󱦟 " }
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "󱦟:: " }

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') 
    ($nu.data-dir | path join 'completions') 
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') 
]

zoxide init nushell | save -f ~/.zoxide.nu

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

$env.BUNDLE_PATH = ''

$env.PATH = ($env.PATH | split row (char esep) | append "/home/fisher/.deno/bin" | append "/home/fisher/.local/share/gem/ruby/3.3.0/bin")
