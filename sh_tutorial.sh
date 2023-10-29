#!/bin/sh

# variables

# basic
test="test variable"
echo "This is a $test"

# get output of a command
now=$(date)
echo "$now"

# more complicated command
wifi=$(iwctl station wlan0 show | grep "Connected network" | awk '{ print $3}')
echo $wifi

# sustem variable
echo $USER


# all environment variables
all_variables=$(env)
# XDG_GREETER_DATA_DIR=/var/lib/lightdm/data/sparklez
# XDG_SESSION_CLASS=user
# HOME=/home/sparklez
# DISPLAY=:0
# DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
# GPG_AGENT_INFO=/run/user/1000/gnupg/S.gpg-agent:0:1
# LANG=en_US.UTF-8
# ALACRITTY_WINDOW_ID=20971524
# LOGNAME=sparklez
# SSH_AGENT_PID=6585
# XDG_VTNR=7
# SSH_AUTH_SOCK=/tmp/ssh-2mncwgzq7qSK/agent.6516
# PWD=/home/sparklez/dotfiles
# DESKTOP_SESSION=awesome
# GDMSESSION=awesome
# QT_IM_MODULE=ibus
# XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session2
# XDG_SESSION_TYPE=x11
# XDG_SESSION_ID=10
# CLUTTER_IM_MODULE=ibus
# TERM=alacritty
# XDG_SEAT=seat0
# XDG_SESSION_DESKTOP=awesome
# VIM=/usr/share/nvim
# ANDROID_SDK_ROOT=/home/sparklez/Android/Sdk/
# XAUTHORITY=/home/sparklez/.Xauthority
# ALACRITTY_LOG=/tmp/Alacritty-6741.log
# ALACRITTY_SOCKET=/run/user/1000/Alacritty-:0-6741.sock
# WINDOWID=20971524
# XDG_RUNTIME_DIR=/run/user/1000
# ANDROID_HOME=/home/sparklez/Android/Sdk/
# GTK3_MODULES=xapp-gtk3-module
# NVIM_LOG_FILE=/home/sparklez/.cache/nvim/log
# XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0
# _JAVA_AWT_WM_NONREPARENTING=1
# VIMRUNTIME=/usr/share/nvim/runtime
# SHLVL=1
# PATH=/home/sparklez/Android/Sdk/platform-tools:/home/sparklez/Android/Sdk/tools/bin:/home/sparklez/Android/Sdk/tools:/home/sparklez/Android/Sdk/emulator:/home/sparklez/Android/Sdk:/home/sparklez/.local/share/nvim/mason/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
# USER=sparklez
# MASON=/home/sparklez/.local/share/nvim/mason
# XMODIFIERS=@im=ibus
# GTK_IM_MODULE=ibus
# MYVIMRC=/home/sparklez/dotfiles/nvim/init.lua
# COLORTERM=truecolor
# QT_QPA_PLATFORMTHEME=qt5ct
# QT_ACCESSIBILITY=1
# SHELL=/usr/bin/fish


# math functions

num1=2
num2=3
# evaluate an expression
expr $num1 + $num2
expr $num1 - $num2
# division gives out an int number
expr $num1 / $num2 # = 0
# multiplication need to escape the *
expr $num1 \* $num2


# if statements

num3=200
# -eq - equal
# -ne - not equal
# -gt - greater then
# man test
if [ $num3 -eq 200 ] # equal
then
	echo "The condition is true"
else
	echo "The condition is false"
fi

if [ $num3 -ne 200 ] # not equal
then
	echo "The condition is true"
else
	echo "The condition is false"
fi

# check if file exists
# -f is for file
# -d is for directory
if [ -f ~/dotfiles/bash_tutorial.sh ]
then
	echo "the file exists"
else
	echo "the file does not exist"
fi

# check if htop is installed
# and run it
#program=$(which htop)
program=htop

# if which $program
# is the same as
if command -v $program
then
	echo "$program is available"
else
	echo "$program not found, installing it"
	# sudo nala update && sudo nala install -y $program
fi
# $program



# exit codes
ls -alh ./bash_tutorial.sh
# exit code is stored
# in the $? variable
# success = 0
# fail = 2
if [ $? -eq 0 ]
then
	echo "The command was successful"
else
	echo "The command failed"
fi

# echo will always give
# an exit code of 0!!!!!!
directory=/etcd
if [ -d $directory ]
then
	# the real exit code is here
	echo $?
	echo "The directory $directory exists"
else
	echo "The directory $directory does not exist"
fi

echo "The exit code for this script is: $?"

# let's try that again
if [ -d $directory ]
then
	echo "The directory $directory exists"
	# force exit code 0
	# evertyhing after that will not run!!!
	# exiting out of the script
	# exit 0
else
	echo "The directory $directory does not exist"
	# force exit code 1
	# evertyhing after that will not run!!!
	# exiting out of the script
	# exit 228
	# exit 1
fi
echo "The exit code for this script is: $?"



# while loops

myvar=1
while [ $myvar -le 10 ]
do
	# redraw the screen for every frame
	clear
	echo $myvar
	myvar=$(( $myvar + 1))
	# set 60 fps
	sleep $(( 1 / 60 ))
done

while [ -f ~/testfile ]
do
	clear
	echo "The test file exists"
done
echo "The test file no longer exists"


# update script

release_file=/etc/os-release
# both of these scripts are trash btw

# if [ -d /etc/apt ]
# if command -v apt
if grep -q "Pop" $release_file || grep -q "Ubuntu" $release_file
then
	sudo apt update
fi

# if [ -d /etc/pacman.d ]
# if command -v pacman
if grep -q "Arch" $release_file
then
	sudo pacman -Sy
fi


# for loops

# the items are separated by space
for n in 1 2 3 4 5 6 7 8 9 10
do
	clear
	echo $n
done
echo "The for loop has ended"

for file in ~/dotfiles/awesome/widgets/*.lua
do
	ls -alh $file
done


# data streams
# stdout
# stderr

# read from stdin
echo "Please enter your name"
read myname
echo "Your name is $myname"
# redirect stdout
ls /etc/apt/ 1> /dev/null
#redirect stderr
ls /etc/apt/ 2> /dev/null


#functions

test_function() {
	echo "This is a test function"
}

test_function


# arguments
# are passed in $1, $2, $3 variables
echo $1 $2 $3 $4
# $# shows the number of passed argments
echo $#
