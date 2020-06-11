#!/bin/bash

BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`
NIGHTVALUE=0.6
DAYVALUE=1.0

if [ `echo "$BRIGHTNESS == 1.0" | bc` -eq 1 ]
then
        SETVALUE=$NIGHTVALUE
else
        SETVALUE=$DAYVALUE
fi

xrandr --output HDMI-0 --brightness $SETVALUE
