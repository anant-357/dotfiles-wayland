let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans 
    | from json 
    | if ($in | default [] | where value =~ '^-.*ERROR: $' | is-empty) { $in } else { null }
}

let external_completer = {|spans| 
    let expanded_alias = scope aliases 
    | where name == $spans.0 
    | get -o 0.expansion

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

source ~/.config/nushell/catppuccin-mocha.nu
source ~/.config/nushell/niri-completions.nu
source ~/.zoxide.nu
