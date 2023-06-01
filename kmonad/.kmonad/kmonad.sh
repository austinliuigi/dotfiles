#!/bin/bash

KBD_DEV=$(cat /proc/bus/input/devices \
    | grep -oE "\".*\"|event[[:digit:]]+" \
    | sed '$!N;s/\n/ /' \
    | fzf \
    | awk '{print "/dev/input/" $NF}')
echo "$KBD_DEV"
export KBD_DEV
KBDCFG=$(envsubst < ~/dotfiles/kmonad/.kmonad/linux.kbd)
# echo "$KBDCFG"

kmonad <(echo "$KBDCFG") &
