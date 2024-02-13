swayidle -w timeout 1200 'swaylock -f -c 000000' \
	timeout 1200 'hyprctl dispatch dpms off' \
	resume 'hyprctl dispatch dpms on' \
	timeout 1800 'systemctl suspend' \
	before-sleep 'swaylock -f -c 000000' &
