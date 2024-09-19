set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

alias pari "yay"
alias cat "bat"
alias ls "eza"

pyenv init - | source

if set -q ZELLIJ
else
  zellij -l welcome
end


if status is-interactive
	eval (zellij setup --generate-auto-start fish | string collect)
    # Commands to run in interactive sessions can go here
end
