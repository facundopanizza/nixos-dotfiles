#!/bin/bash

# Screenshot directory
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Define the options
options="Screen\nWindow\nRegion"

# Display the Rofi menu and get the chosen option
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Screenshot:")

# Execute a command based on the chosen option
case $chosen in
    "Screen")
        hyprshot -m output -o "$SCREENSHOT_DIR"
        ;;
    "Window")
        hyprshot -m window -o "$SCREENSHOT_DIR"
        ;;
    "Region")
        hyprshot -m region -o "$SCREENSHOT_DIR"
        ;;
esac

