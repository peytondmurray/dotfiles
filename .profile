#!/bin/bash

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_FONT_DPI=100
export QT_QPA_PLATFORMTHEME=breeze
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_TYPE=wayland
export MOZ_ENABLE_WAYLAND=1

export GTK_THEME=Adwaita:dark

if [[ -z "${DISPLAY}" && $(tty) == "/dev/tty1" ]]; then
    exec start-hyprland
fi
