#!/bin/bash

# list of themes

themes=("dracula" "gruvbox" "monochrome" "everforest")

declare -A theme_colors=(
	[dracula_dark]="#282a36:#e8e8e2"
	[dracula_light]="#f8f8f2:#282a36"
	[gruvbox_dark]="#282828:#ebdbb2"
	[gruvbox_light]="#ebdbb2:#282828"
	[monochrome_dark]="#282828:#f8f8f8"
	[monochrome_light]="#f8f8f8:#282828"
	[everforest_dark]="#2D353B:#D3C6AA"
	[everforest_light]="#FDF6E3:#5C6A72"
)
declare -A vim_name=(
	[dracula_dark]="dracula"
	[dracula_light]="dracula"
	[gruvbox_dark]="gruvbox"
	[gruvbox_light]="gruvbox"
	[monochrome_dark]="monochrome"
	[monochrome_light]="monochrome"
	[everforest_dark]="everforest"
	[everforest_light]="everforest"
)

declare -A config_list=(
	[zathura]="${HOME}/.config/zathura/zathurarc"
	[wezterm]="${HOME}/.config/wezterm/wezterm.lua"
	[neovim]="${HOME}/.config/nvim/lua/plugins/core.lua"
	[colors]="${HOME}/.config/theme/colors.scss"
	[sway]="${HOME}/.config/sway/config"
	[neovim_plugins]="${HOME}/.config/nvim/lua/plugins.lua"
)

themes_str=""

for theme_name in ${themes[@]}; do
	themes_str="${themes_str}$theme_name\n"
done

chosen_theme=$(echo -e $themes_str | rofi -dmenu)
mode=$(echo -e "light\ndark" | rofi -dmenu)

if [ "$mode" = "" ]; then
	exit 1
fi
chosen_theme="$chosen_theme"_"$mode"

background="${HOME}/dotfiles-wayland/wallpapers/${chosen_theme}"

if [ -f "${background}.jpg" ]; then
	background="${background}.jpg"
elif [ -f "${background}.png" ]; then
	background="${background}.png"
elif [ -f "${background}.jpeg" ]; then
	background="${background}.jpeg"
else
	echo "Unable to find background ${background}.jpg/.png/.jpeg"
	exit 1
fi

echo $chosen_theme

case $chosen_theme in
"dracula_dark")
	sed -i "/color_scheme=/c color_scheme='Dracula (Gogh)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Dracula (Gogh)']" ${config_list[wezterm]}
	;;
"dracula_light")
	sed -i "/color_scheme=/c color_scheme='Dracula (Gogh)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Dracula (Gogh)']" ${config_list[wezterm]}
	;;
"gruvbox_dark")
	sed -i "/color_scheme=/c color_scheme='Gruvbox Dark (Gogh)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Gruvbox Dark (Gogh)']" ${config_list[wezterm]}
	;;
"gruvbox_light")
	sed -i "/color_scheme=/c color_scheme='Gruvbox (Gogh)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Gruvbox (Gogh)']" ${config_list[wezterm]}
	;;
"monochrome_dark")
	sed -i "/color_scheme=/c color_scheme='Mono Theme (terminal.sexy)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Mono Theme (terminal.sexy)']" ${config_list[wezterm]}
	;;
"monochrome_light")
	sed -i "/color_scheme=/c color_scheme='Mono Theme (terminal.sexy)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Mono Theme (terminal.sexy)']" ${config_list[wezterm]}
	;;
"everforest_dark")
	sed -i "/^ *color_scheme=/c color_scheme='Everforest Dark (Gogh)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Everforest Dark (Gogh)']" ${config_list[wezterm]}
	;;
"everforest_light")
	sed -i "/^ *color_scheme=/c color_scheme='Everforest Light (Gogh)'," ${config_list[wezterm]}
	sed -i "/get_builtin_color_schemes/c local scheme = wezterm.get_builtin_color_schemes()['Everforest Light (Gogh)']" ${config_list[wezterm]}
	;;
esac

echo -e "\$background: $(echo ${theme_colors[$chosen_theme]} | cut -d ':' -f 1);\n\$foreground:  $(echo ${theme_colors[$chosen_theme]} | cut -d ':' -f 2);" >${config_list[colors]}
#sed -i "/vim.cmd.colorscheme/c vim.cmd.colorscheme '$(echo ${vim_name[$chosen_theme]})'" ${config_list[neovim]}
sed -i "/colorscheme/c colorscheme = '$(echo ${vim_name[$chosen_theme]})'" ${config_list[neovim]}
#sed -i "/vim.opt.background/c vim.opt.background='$(echo $mode)'" ${config_list[neovim]}
sed -i "/set recolor-lightcolor/c set recolor-lightcolor  \"$(echo ${theme_colors[$chosen_theme]} | cut -d ":" -f 1)\"" ${config_list[zathura]}
sed -i "/set recolor-darkcolor/c set recolor-darkcolor \"$(echo ${theme_colors[$chosen_theme]} | cut -d ":" -f 2)\"" ${config_list[zathura]}
sed -i "/set default-bg/c set default-bg \"$(echo ${theme_colors[$chosen_theme]} | cut -d ":" -f 1)\"" ${config_list[zathura]}
sed -i "/set default-fg/c set default-fg \"$(echo ${theme_colors[$chosen_theme]} | cut -d ":" -f 2)\"" ${config_list[zathura]}
#sed -i "/theme =/c theme = '$(echo ${vim_name[$chosen_theme]})'," ${config_list[neovim_plugins]}

swaymsg output eDP-1 bg $background fill

sed -i "/output eDP-1 bg/c output eDP-1 bg $background fill" ${config_list[sway]}

eww kill
eww open bottombar
exit 1
