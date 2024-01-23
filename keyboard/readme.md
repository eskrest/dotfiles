To change the KP_Enter to Return code on keyboard:

First, make a backup copy of your original file /usr/share/X11/xkb/keycodes/evdev

Change:

<KPEN> = 36;
<RTRN> = 104;

Reboot, or restart Xorg.
