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

power_now=$(cat $battery/power_now)
power_centiwatt=$((power_now / 10000))
power_watt_integer_part=$((power_centiwatt / 100))
power_watt_decimal_part=$((power_centiwatt % 100))
power_watt_decimal_part=$(printf '%02d' $power_watt_decimal_part)
power_watt="${power_watt_integer_part}.${power_watt_decimal_part}"
status=$(cat $battery/status)

if [ $status == 'Discharging' ]; then
    text="-${power_watt}W"
    if [ $power_now -ge 15000000 ]; then
        class='critical'
    elif [ $power_now -ge 9000000 ]; then
        class='warning'
    fi
else
    text="${power_watt}W"
fi

echo "{\"text\": \"$text\", \"class\": \"$class\"}"
