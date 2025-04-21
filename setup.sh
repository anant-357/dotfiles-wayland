user_configs=(
    bat
    dunst
    fuzzel
    ghostty
    niri
    nvim
    nushell
    systemd
    way-edges
    zathura
)

user_home_configs=(
    git
    
)

run_stow() {
    usr=$1
    app=$2
    stow -v -R -t ${usr} ${app}
}

echo ""
echo "Setting up apps for $(whoami)"

for app in ${user_configs[@]}; do
    run_stow "${HOME}" $app
done

for app in ${user_home_configs[@]}; do
    run_stow "${HOME}" $app
done

echo ""
echo "Done!"
