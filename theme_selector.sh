#!/bin/bash

# list of themes

themes=("dracula" "gruvbox" "monochrome")
declare -A theme_colors=( [dracula]="#282a36:#e8e8e2" [gruvbox]="#ebdbb2:#282828" [monochrome]="#282828:#f8f8f8" )

declare -A config_list=( [zathura]="${HOME}/.config/zathura/zathurarc" [wezterm]="${HOME}/.config/wezterm/wezterm.lua" [neovim]="${HOME}/.config/nvim/lua/settings.lua" [colors]="${HOME}/.config/theme/colors.scss" [sway]="${HOME}/.config/sway/config" [neovim_plugins]="${HOME}/.config/nvim/lua/plugins.lua" )

themes_str=""

for theme_name in ${themes[@]};
do
	themes_str="${themes_str}$theme_name\n"
done

chosen_theme=$(echo -e $themes_str | rofi -dmenu)

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


#sed -i '/This is my line/c Dracula doing disco' test1
echo ${theme_colors[$chosen_theme]}


case $chosen_theme in 
	"dracula")
		sed -i "/color_scheme/c color_scheme='Dracula (Gogh)'," ${config_list[wezterm]}
				;;
	"gruvbox")
		sed -i "/color_scheme/c color_scheme='Gruvbox Dark (Gogh)'," ${config_list[wezterm]}
		;;
	"monochrome")
		sed -i "/color_scheme/c color_scheme='Mono Theme (terminal.sexy)'," ${config_list[wezterm]}
		;;
esac 

corner_radius=12
corner_radius_str=$(echo "/corner_radius/c corner_radius ${corner_radius}")
corner_radius_str="${corner_radius_str}"

echo $corner_radius_str


echo -e "\$background: $(echo ${theme_colors[$chosen_theme]} |  cut -d ':' -f 1);\n\$foreground:  $(echo ${theme_colors[$chosen_theme]} |  cut -d ':' -f 2);" > ${config_list[colors]}
sed -i "/vim.cmd.colorscheme/c vim.cmd.colorscheme '$chosen_theme'" ${config_list[neovim]}
sed -i "/set recolor-lightcolor/c set recolor-lightcolor  \"$(echo ${theme_colors[$chosen_theme]} |  cut -d ":" -f 1)\"" ${config_list[zathura]}
sed -i "/set recolor-darkcolor/c set recolor-darkcolor \"$(echo ${theme_colors[$chosen_theme]} |  cut -d ":" -f 2)\"" ${config_list[zathura]}
sed -i "/set default-bg/c set default-bg \"$(echo ${theme_colors[$chosen_theme]} |  cut -d ":" -f 1)\"" ${config_list[zathura]}
sed -i "/set default-fg/c set default-fg \"$(echo ${theme_colors[$chosen_theme]} |  cut -d ":" -f 2)\"" ${config_list[zathura]}
sed -i "/theme =/c theme = '$chosen_theme'," ${config_list[neovim_plugins]}

swaymsg output eDP-1 bg $background fill

sed -i "/output eDP-1 bg/c output eDP-1 bg $background fill" ${config_list[sway]}
sed -i "${corner_radius_str}" ${config_list[sway]}

eww kill;eww open bottombar
