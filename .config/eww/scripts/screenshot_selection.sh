#!/bin/sh
eww close screenshotmenu
sleep 1
grim -g "$(slurp)" - | wl-copy
