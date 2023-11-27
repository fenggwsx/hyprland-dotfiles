#!/bin/sh

if [ ! $1 ]; then
    battery='/sys/class/power_supply/BAT0'
else
    battery="/sys/class/power_supply/$1"
fi

if [ ! -d $battery ]; then
    echo "$battery dos not exist"
    exit 1
fi

energy_now=$(cat $battery/energy_now)
energy_full=$(cat $battery/energy_full)
energy_cWh=$((energy_now / 10000))
energy_Wh_integer_part=$((energy_cWh / 100))
energy_Wh_decimal_part=$((energy_cWh % 100))
energy_Wh_decimal_part=$(printf '%02d' $energy_Wh_decimal_part)
energy_Wh="${energy_Wh_integer_part}.${energy_Wh_decimal_part}"
energy_permillage=$((energy_now * 1000 / energy_full))
text="${energy_Wh}Wh"

status=$(cat $battery/status)

case $status in
    'Discharging')
        alt="battery-$((energy_permillage / 100))"
        if [ $energy_permillage -le 150 ]; then
            class='critical'
        elif [ $energy_permillage -le 300 ]; then
            class='warning'
        fi;;
    'Charging')
        alt="charging-$((energy_permillage / 100))";;
    'Full')
        alt='full';;
    'Not charging')
        alt='full';;
esac

echo "{\"text\":\"$text\", \"alt\": \"$alt\", \"class\": \"$class\"}"
