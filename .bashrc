#!/bin/bash
if [ ! -n "$FEED_BOOKMARKS" ]; then export FEED_BOOKMARKS=$HOME/.feed_bookmarks; fi
if [ ! -d "$FEED_BOOKMARKS" ]; then mkdir -p $FEED_BOOKMARKS; fi

feed() {
	if [ ! -d $FEED_BOOKMARKS ]; then mkdir $FEED_BOOKMARKS; fi

	if [ ! -n "$1" ]; then
		echo -e "\\n \\e[04mUsage\\e[00m\\n\\n   \\e[01;37m\$ feed \\e[01;31m<url>\\e[00m \\e[01;31m<new bookmark?>\\e[00m\\n\\n \\e[04mSee also\\e[00m\\n\\n   \\e[01;37m\$ deef\\e[00m\\n"
		return 1;
	fi

	local rss_source="$(curl --silent $1 | sed -e ':a;N;$!ba;s/\n/ /g')";

	if [ ! -n "$rss_source" ]; then
		echo "The feed is empty";
		return 1;
	fi

	# THE RSS PARSER
	# The characters "£, §" are used as metacharacters. They should not be encountered in a feed...
	echo -e "$(echo $rss_source | \
		sed -e 's/&amp;/\&/g
		s/&lt;\|&#60;/</g
		s/&gt;\|&#62;/>/g
		s/<\/a>/£/g
		s/href\=\"/§/g
		s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m ::\\n/g
		s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
		s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
		s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
		s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
		s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
		s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
		s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
		s/<a[^§]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
		s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
		s/<!\[CDATA\[\|\]\]>//g
		s/\|>\s*<//g
		s/ *<[^>]\+> */ /g
		s/[<>£§]//g')\n\n";
	# END OF THE RSS PARSER

	if [ -n "$2" ]; then
		echo "$1" > $FEED_BOOKMARKS/$2
		echo -e "\\n\\t\\e[01;37m==> \\e[01;31mBookmark saved as \\e[01;36m\\e[04m$2\\e[00m\\e[01;37m <==\\e[00m\\n"
	fi
}

deef() {
	if test -n "$1"; then
		if [ ! -r "$FEED_BOOKMARKS/$1" ]; then
			echo -e "\\n \\e[01;31mBookmark \\e[01;36m\\e[04m$1\\e[00m\\e[01;31m not found.\\e[00m\\n\\n \\e[04mType:\\e[00m\\n\\n   \\e[01;37m\$ deef\\e[00m (without arguments)\\n\\n to get the complete list of all currently saved bookmarks.\\n";
			return 1;
		fi
		local url="$(cat $FEED_BOOKMARKS/$1)";
		if [ ! -n "$url" ]; then
			echo "The bookmark is empty";
			return 1;
		fi
		echo -e "\\n\\t\\e[01;37m==> \\e[01;31m$url\\e[01;37m <==\\e[00m"
		feed "$url";
	else
		echo -e "\\n \\e[04mUsage\\e[00m\\n\\n   \\e[01;37m\$ deef \\e[01;31m<bookmark>\\e[00m\\n\\n \\e[04mCurrently saved bookmarks\\e[00m\\n";
		for i in $(find $FEED_BOOKMARKS -maxdepth 1 -type f);
			do echo -e "   \\e[01;36m\\e[04m$(basename $i)\\e[00m";
		done;
		echo -e "\\n \\e[04mSee also\\e[00m\\n\\n   \\e[01;37m\$ feed\\e[00m\\n";
	fi;
}

#My old bashrc aliases
#Run the git ssh bash script on startup
source ~/.scripts/gitssh.sh

#get zshrc like completion
bind 'set show-all-if-ambiguous on'
#bind 'set show-all-if-unmodified on'

#The tab completion is pretty annoying, in my opinion it's better to tap twice and keep typing, 
#which is what bash does by default
#bind 'TAB:menu-complete'
# for shift-tab to complete backwards
#bind '"\e[Z":menu-complete-backward'

alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias grep="grep --color=auto"
alias dmesg='dmesg --color'

# Uncomment the "Color" line in /etc/pacman.conf instead of uncommenting the following line...!

alias pacman="pacman --color=auto"

alias sudo="sudo "

function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias 'cd..'='cd_up'

#some useful shortcuts:
alias getsong="youtube-dl -f bestaudio -o '~/Music/youtube/%(title)s.%(ext)s' --proxy \"\""	#get youtube song
alias youtube-dl="youtube-dl --proxy \"\""
alias dim="echo 53 | sudo tee  /sys/class/backlight/amdgpu_bl0//brightness"
alias halfdim="echo 80 | sudo tee  /sys/class/backlight/amdgpu_bl0//brightness"
alias bright="echo 255 | sudo tee  /sys/class/backlight/amdgpu_bl0//brightness"
alias zathura="zathura --fork"
alias lock="~/config/lockscreen.sh"
alias la="ls -la"
alias ll='ls -l'
alias l='ls -CF'
alias ume='ume "cd `xcwd`"'
alias sshUC="ssh haiyang.he@linuxlab.cpsc.ucalgary.ca -Y"
alias sshUCARM="ssh haiyang.he@arm.cpsc.ucalgary.ca -Y"
alias udiskmount="udisksctl mount -b "
alias udiskunmount="udisksctl unmount -b "
alias n="nvim"
alias ga='git add'
alias gs='git status'
alias gc='git commit'
#alias gfix='git rebase -i HEAD~2'
#alias gl='git log --pretty=short'
alias gb='git branch'
alias gco='git checkout'

export http_proxy=""
export https_proxy=""

badresponse=("soo bad wdf" "jared god me bad carry mee" "soo trash wdf" "soo badd" "sooobaddwdffff" "I wish I can do this with one fold")

#plus one here because its zsh
alias bad='git add . && git commit -m "${badresponse[$(($RANDOM % ${#badresponse[@]}))]}" && git pull  && git push'

#set bash to vim bindings:
#should also put the following 2 lines in your .inputrc:
#set editing-mode vi
#set keymap vi-command
#set -o vi
#when press 'v' in normal mode, it will bring you to a editor to edit the command, then save quit to run the command..
export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="st"
#only show 3 dir depth so your screen does not get overwhelmed with paths..
export PROMPT_DIRTRIM=3

#export BROWSER="chromium"
export BROWSER="qutebrowser"

#wine that uses deepin 5 (maybe not need? but for now its good)
export WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat"
export WINEDLLPATH=/usr/lib/i386-linux-gnu/deepin-wine5
export WINELOADER=/usr/lib/i386-linux-gnu/deepin-wine5/wine
export WINESERVER=/usr/lib/i386-linux-gnu/deepin-wine5/wineserver

# Git stuff
if [[ $PS1 && -f /usr/share/git/git-prompt.sh ]]; then
    source /usr/share/git/git-prompt.sh

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    if ${use_color} ; then
        PS1='\[\e[1;92m\]\u@\h\[\e[m\] \[\e[1;94m\]\w\[\e[m\] \[\e[1;91m\]$(__git_ps1 "(%s)")\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[1;0m\]'
    else
        PS1='\u \W $(__git_ps1 "(%s)")\$ '
    fi

fi


#add my scripts to the path so I don't need to manually type them
export PATH=$PATH:~/.local/bin/:~/.scripts:~/dwmblocks-haiyang/scripts

export DENO_INSTALL="/home/haiyang/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# nvim server addr 
# if multiple nvim buffers are opened, only one of them gets the /tmp/nvimsocket
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

#ignore duplicate histories
export HISTCONTROL=ignoreboth:erasedups
# append to the history instead of overwriting (good for multiple connections)
shopt -s histappend

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
wallpaper=/home/haiyang/.config/wallpaper/dracula_arch.png
