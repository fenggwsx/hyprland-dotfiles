#!/bin/sh

function send_notification {
    brightness=$(light -G | awk -F. '{print $1}')
    let angle=(brightness+2)/5*5
    ico="$HOME/.config/dunst/icons/vol/vol-${angle}.svg"
    notify-send 'Brightness' "current brightness: $brightness" -i $ico -a 'light' -r 91190 -t 800
}

case $1 in
i)  light -A 5
    send_notification ;;
d)  light -U 5
    send_notification ;;
esac
