#!/usr/bin/env bash

swww-daemon &
sleep 1
swww img ~/Wallpapers/1337277.jpeg &

nm-applet --indicator &

waybar &

dunst &

hyprctl setcursor Bibata-Modern-Ice 24
