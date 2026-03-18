alias pari = paru
alias cat = bat
alias ls = eza
alias vim = nvim
alias vimdiff = nvim -d

pyenv init - | source 

zellij attach gracious-muskrat

ssh-agent -c
    | lines
    | first 2
    | parse "setenv {name} {value};"
    | transpose -r
    | into record
    | load-env
