# Define alias in shell
alias ll "ls -alh"
alias df "df -h"
# alias ff "df | grep /dev/"
alias dcd "docker-compose down"
alias dcu "docker-compose up --build -d"
# alias wine32 "WINEPREFIX='/home/sparklez/.wine32' WINEARCH='win32'"
# alias ge "/home/sparklez/.local/share/lutris/runners/wine/lutris-GE-Proton8-5-x86_64/bin/wine"
# alias gedbg "/home/sparklez/.local/share/lutris/runners/wine/lutris-GE-Proton8-5-x86_64/bin/winedbg"
alias nv "~/Documents/./nvim.appimage"

# Environment variables
set -gx ANDROID_SDK_ROOT ~/Android/Sdk/
set -gx ANDROID_HOME ~/Android/Sdk/
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/tools/bin
fish_add_path $ANDROID_HOME/platform-tools
