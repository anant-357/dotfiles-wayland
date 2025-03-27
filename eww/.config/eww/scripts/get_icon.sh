#!/bin/bash
app_id=$(niri msg -j windows | jq -r '.[] | select(.is_focused == true) | .app_id')
app_id=${app_id,,}
desktop_file=$(find /var/lib/flatpak/exports/share/applications /usr/share/applications ~/.local/share/applications -name "*$app_id*.desktop" | head -n 1)
icon_name=$(grep -i '^Icon=' "$desktop_file" | cut -d= -f2)
icon_path=$(find /var/lib/flatpak/exports/share/icons/hicolor /usr/share/icons -name "$icon_name.*" | head -n 1)
echo $icon_path
