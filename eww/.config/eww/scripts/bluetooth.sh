#!/bin/bash
declare -A icons

icons["audio-headphones"]='󰋋'
icons["audio-headset"]=''

icon="󰚌"

# Check if bluetooth module is available
if ! command -v bluetoothctl &> /dev/null; then
  icon="󰚌"
  exit 0
fi

# Get bluetooth power status
bluetoothctl show | grep "Powered: yes" > /dev/null 2>&1
if [ $? -eq 0 ]; then
  bluetoothctl info | grep "Icon:" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
  icon_name=$(bluetoothctl info | grep "Icon:" | awk '{print $2}')

  battery_hex=$(bluetoothctl info | grep "Battery Percentage:" | awk '{print $3}')
  icon=${icons[$icon_name]} 
else
  icon="󰂯"
fi
else
  icon="󰂲"
fi

battery_dec=$(printf "%d\n" $battery_hex)

echo "{\"icon\": \"$icon\", \"battery\": \"$battery_dec\"}"
