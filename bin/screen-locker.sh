#!/bin/sh

swayidle -w \
    timeout 600 'swaylock -f' \
    before-sleep 'swaylock -f'
