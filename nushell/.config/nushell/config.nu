let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans 
    | from json 
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let external_completer = {|spans| 
    let expanded_alias = scope aliases 
    | where name == $spans.0 
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
            $spans 
            | skip 1
            | prepend ($expanded_alias | split row ' ' | take 1)
        } else {
            $spans 
            }
    match $spans.0 {
        __zoxide_z | __zoxide_zi => $zoxide_completer 
        _ => $carapace_completer 
        } | do $in $spans 
}

$env.config = {
    show_banner: false,
    completions: {
        external: {
            enable: true,
            completer: $external_completer
            },
        },
    }

def start_zellij [] {
    if 'ZELLIJ' not-in ($env | columns) {
        zellij attach gracious-muskrat
        if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
                exit 
                }
        }
    }

source ~/.zoxide.nu
source ~/.config/nushell/catppuccin-mocha.nu


use ~/.cache/starship/init.nu

start_zellij
