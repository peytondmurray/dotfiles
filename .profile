#!/bin/bash

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_FONT_DPI=100
export QT_QPA_PLATFORMTHEME=breeze
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=hyprland
export MOZ_ENABLE_WAYLAND=1

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export GTK_THEME=Adwaita:dark

# Use AMDVLK vulkan implementation.
export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
ICD_DIR="/usr/share/vulkan/icd.d"
export VK_ICD_FILENAMES="${ICD_DIR}/radeon_icd.i686.json:${ICD_DIR}/radeon_icd.x86_64.json"

if [[ -z "${DISPLAY}" && $(tty) == "/dev/tty1" ]]; then
    exec Hyprland
fi
