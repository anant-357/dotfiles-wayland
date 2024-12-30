set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

alias pari "paru"
alias cat "bat"
alias ls "eza"
alias vim "nvim"
alias vimdiff "nvim -d"

if status is-interactive
    pyenv init - | source
    if not set -q ZELLIJ
        zellij attach gracious-muskrat
    end
    zoxide init fish | source
end
