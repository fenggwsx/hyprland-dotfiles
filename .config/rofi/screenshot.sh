#!/bin/sh

## Applets : Screenshot

# Options
option_1=" Capture Area"
option_2=" Capture Window"
option_3=" Capture Desktop"

# Rofi CMD
rofi_cmd() {
    rofi -theme-str "listview {columns: 1; lines: 3;}" \
        -dmenu \
        -mesg "DIR: ~/Pictures/screenshots" \
        -markup-rows \
        -theme screenshot.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
geometry=`xrandr | grep 'current' | head -n1 | cut -d',' -f2 | tr -d '[:blank:],current'`
dir="$HOME/Pictures/screenshots"
file="${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

# take shots
shotdesktop () {
    sleep 1 && hyprshot -m output -o "$dir"
}

shotwin () {
    sleep 1 && hyprshot -m window -o "$dir"
}

shotarea () {
    sleep 1 && hyprshot -m region -o "$dir"
}

# Execute Command
run_cmd() {
    if [[ "$1" == '--opt1' ]]; then
        shotarea
    elif [[ "$1" == '--opt2' ]]; then
        shotwin
    elif [[ "$1" == '--opt3' ]]; then
        shotdesktop
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
        run_cmd --opt1
        ;;
    $option_2)
        run_cmd --opt2
        ;;
    $option_3)
        run_cmd --opt3
        ;;
esac
