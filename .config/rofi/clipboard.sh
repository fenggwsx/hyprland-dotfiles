#!/bin/sh

rofi_cmd() {
    rofi -dmenu \
        -theme clipboard.rasi
}

run_rofi() {
    cliphist list | rofi_cmd
}

chosen="$(run_rofi)"
if [ $? -eq 0 ]; then
    echo -e "$chosen" | cliphist decode | wl-copy
fi

