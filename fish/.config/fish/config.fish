set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

alias pari "paru"
alias cat "bat"
alias ls "eza"

if status is-interactive

    # Commands to run in interactive sessions can go here
end
