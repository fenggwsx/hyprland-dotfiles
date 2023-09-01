#!/usr/bin/env sh

function print_error
{
    cat << "EOF"
volume control tool
Usage:
  ./volumecontrol.sh -[device] <action>
  ...valid device are...
    i -- [i]nput decive
    o -- [o]utput device
  ...valid actions are...
    i -- <i>ncrease volume [+5]
    d -- <d>ecrease volume [-5]
    m -- <m>ute [x]
EOF
    exit 1
}

function notify_vol
{
    vol=$(pamixer $srce --get-volume)
    let angle=(vol+2)/5*5
    ico="$icodir/vol-${angle}.svg"
    notify-send "volctl" "$nsink" -a "$vol" -i $ico -r 91190 -t 800
}

function notify_mute
{
    mute=$($(pamixer $srce --get-mute) && echo 'muted' || echo 'unmuted')
    ico="${icodir}/${mute}-${dvce}.svg"
    notify-send 'volctl' "$nsink" -a "$mute" -i $ico -r 91190 -t 800
}

while getopts io SetSrc
do
    case $SetSrc in
    i)  nsink=$(pamixer --list-sources | grep '_input.' | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
        srce='--default-source'
        dvce='mic' ;;
    o)  nsink=$(pamixer --get-default-sink | grep '_output.' | awk -F '" "' '{print $NF}' | sed 's/"//')
        srce=''
        dvce='speaker' ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    print_error
fi

shift $((OPTIND -1))
icodir="$HOME/.config/dunst/icons/vol"
step="${2:-5}"

case $1 in
    i)  pamixer $srce -u
        pamixer $srce -i ${step}
        notify_vol ;;
    d)  pamixer $srce -u
        pamixer $srce -d ${step}
        notify_vol ;;
    m)  pamixer $srce -t
        notify_mute ;;
esac

