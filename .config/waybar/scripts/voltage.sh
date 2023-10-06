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

voltage_now=$(cat $battery/voltage_now)
voltage_centivolt=$((voltage_now / 10000))
voltage_volt_integer_part=$((voltage_centivolt / 100))
voltage_volt_decimal_part=$((voltage_centivolt % 100))
voltage_volt_decimal_part=$(printf '%02d' $voltage_volt_decimal_part)
voltage_volt="$voltage_volt_integer_part.$voltage_volt_decimal_part"
status=$(cat $battery/status)
text="${voltage_volt}V"

if [ $voltage_now -ge 20000000 ]; then
    class='critical'
elif [ $voltage_now -ge 16000000 ]; then
    class='warning'
fi

echo "{\"text\": \"$text\", \"class\": \"$class\"}"
