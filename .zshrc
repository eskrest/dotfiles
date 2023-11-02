# Set up the prompt
autoload -U colors && colors
LS_COLORS="ow=1;105;30:di=1;34"
export LS_COLORS

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
			echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins 
	# initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set
	# elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#
# onedark theme colors
black="#282C34"
red="#E06C75"
green="#98C379"
yellow="#E5C07B"
blue="#61AFEF"
purple="#C678DD"
cyan="#56B6C2"
gray="#ABB2BF"
white="#FFFFFF"

# curtom prompt
#
delimiter=""
prelimiter=""

shpwd() {
	echo ${${:-/${(j:/:)${(M)${(s:/:)${(D)PWD:h}}#(|.)[^.]}}/${PWD:t}}//\/~/\~}
}

get_user() {
	echo %F{$blue}$prelimiter%f%K{$blue} %F{$black}%n@%m%f %k%K{$purple}%F{$blue}$delimiter%f%k
}

get_pwd() {
	echo %K{$purple}%F{$black}$(shpwd)%f%k%K{$purple}%F{$purple}$delimiter%f%k
}

get_branch() {
	if [ ! -z "$vcs_info_msg_0_" ]
	then
		echo "%K{$purple}%F{$green}$prelimiter%f%k%K{$green}%F{$black} ${vcs_info_msg_0_}%k%f%F{$green}$delimiter%f "
	else
		echo "%F{$purple}$delimiter%f "
	fi
}

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%B$(get_user)$(get_pwd)$(get_branch)%b'

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# aliases
# ls() {
# 	if [ -t 1 ]; then
# 		command ls "$@"| sed "s/sparklez /${fg[blue]}sparklez${reset_color} /g" | sed "s/\([-|d|l][-|r][-|w][-|x]\)\([-|r][-|w][-|x]\)\([-|r][-|w][-|x]\)/${fg[yellow]}\1${fg[blue]}\2${fg[red]}\2${reset_color}/g"
# 
# 
# 	else
# 		command ls "$@"
# 	fi
# }
# alias ls=ls
alias ll="ls -alhAF --color=auto"
alias ..="cd .."
alias df="df -h"
alias dcd="docker-compose down"
alias dcu="docker-compose up --build -d"
alias gtp="cd /home/sparklez/docker-containers/7php/proj/palitra"
alias gta="cd /home/sparklez/docker-containers/7php/proj/academy"

# Environment variables
export ANDROID_SDK_ROOT=~/Android/Sdk
export ANDROID_HOME=~/Android/Sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
