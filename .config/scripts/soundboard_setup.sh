#!/bin/bash

killall -q pw-loopback

pw-loopback -m '[ FL FR ]' --capture-props='media.class=Audio/Sink node.name=restream2input node.description="Restream 2 Input"' --playback-props='media.class=Audio/Source node.name=restream2nomic node.description="Restream 2 Output (NOMIC)"' &
pw-loopback -m '[ FL FR ]' --capture-props='node.name=restream2alb node.description="Restream 2 Audio (Loopback)" node.target=restream2nomic' --playback-props='node.name=restream2mixer node.description="Restream 2 Audio"' &
pw-loopback -m '[ FL FR ]' --capture-props='node.name=restream2olb node.description="Restream 2 Output (Loopback)" node.target=restream2nomic' --playback-props='media.class=Audio/Source node.name=restream2output node.description="Restream 2 Output"' &
pw-loopback -m '[ FL FR ]' --capture-props='node.name=restream2mlb node.description="Restream 2 Mixer (Loopback)"' --playback-props='node.name=restream2mixer node.description="Restream 2 Mixer" node.target=restream2olb' &
