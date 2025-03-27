#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

xrdb -merge ~/.Xresources

remaps

feh --no-fehbg --bg-fill ~/.misc/bg.webp

/usr/lib/x86_64-linux-gnu/xfce4/notifyd/xfce4-notifyd &

dbus-update-activation-environment --verbose --systemd \
	DBUS_SESSION_BUS_ADDRESS \
	DISPLAY \
	XAUTHORITY \
	XDG_CURRENT_DESKTOP

exec dwm
