set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

if status is-interactive

    # Commands to run in interactive sessions can go here
end
