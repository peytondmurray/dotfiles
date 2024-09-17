#!/bin/bash

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_FONT_DPI=100
export QT_QPA_PLATFORMTHEME=breeze
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=hyprland
export MOZ_ENABLE_WAYLAND=1
export WLR_NO_HARDWARE_CURSORS=1

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export GTK_THEME=Adwaita:dark

if [[ -z "${DISPLAY}" && $(tty) == "/dev/tty1" ]]; then
    exec Hyprland
fi
