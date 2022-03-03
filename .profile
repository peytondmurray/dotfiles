export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_FONT_DPI=100
export QT_QPA_PLATFORMTHEME=breeze
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway


if [[ -z "${DISPLAY}" && $(tty) == "/dev/tty1" ]]; then
    exec sway
fi
