#source ~/.config/antigen.zsh

#antigen bundle git
#antigen bundle zsh-users/zsh-syntax-highlighting
source ~/.antigen/bundles/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
fpath=(~/.antigen/bundles/zsh-users/zsh-completions/src $fpath)


# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/.zshhist
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory nomatch
unsetopt autocd beep extendedglob notify

bindkey -e
# End of lines configured by zsh-newuser-install

# Basic auto/tab complete:
autoload -U compinit #&& compinit

autoload -U bashcompinit && bashcompinit

zstyle ':completion:*' menu select matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
#compinit
_comp_options+=(globdots)		# Include hidden files.


autoload -U colors && colors


#My old bashrc aliases
#Run the git ssh bash script on startup
source ~/.scripts/gitssh.sh

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
alias bright="echo 255 | sudo tee  /sys/class/backlight/amdgpu_bl0//brightness"
alias zathura="zathura --fork"
alias lock="~/config/lockscreen.sh"
alias la="ls -la"
alias ll='ls -l'
alias l='ls -CF'
alias ume='ume "cd `xcwd`"'
alias sshUC="ssh haiyang.he@linux.cpsc.ucalgary.ca -Y"
alias sshUCARM="ssh haiyang.he@arm.cpsc.ucalgary.ca -Y"
alias udiskmount="udisksctl mount -b "
alias udiskunmount="udisksctl unmount -b "
alias n="nvim"

export http_proxy=""
export https_proxy=""

badresponse=("soo bad wdf" "jared god me bad carry mee" "soo trash wdf" "soo badd" "sooobaddwdffff" "I wish I can do this with one fold")

#plus one here because its zsh
alias bad='git add . && git commit -m "${badresponse[$(($RANDOM % ${#badresponse[@]} +1))]}" && git pull  && git push'

#set bash to vim bindings:
#should also put the following 2 lines in your .inputrc:
#set editing-mode vi
#set keymap vi-command
#set -o vi
#when press 'v' in normal mode, it will bring you to a editor to edit the command, then save quit to run the command..
export VISUAL="vim"
#only show 3 dir depth so your screen does not get overwhelmed with paths..
export PROMPT_DIRTRIM=3

# Git stuff
if [[ $PS1 && -f /usr/share/git/git-prompt.sh ]]; then
    source /usr/share/git/git-prompt.sh

    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1

    setopt PROMPT_SUBST 

    PS1='%B%{$fg[green]%}%n%{$fg[green]%}@%{$fg[green]%}%M %{$fg[blue]%}%(5~|%-1~/…/%3~|%4~)%{$fg[red]%}$(__git_ps1 " (%s)")%{$fg[green]%}\$ %b'
    #PS1='[%n@%m %{$fg[blue]%}%c$(__git_ps1 " (%s)")]\$ '
    #PS1="%B%{$fg[green]%}%n%{$fg[green]%}@%{$fg[green]%}%M %{$fg[blue]%}%(5~|%-1~/…/%3~|%4~) %{$fg[blue]%}%c$(__git_ps1 " (%s)")\$%b"
    #PS1="\[\e[1;92m\]\u@\h\[\e[m\] \[\e[1;94m\]\w\[\e[m\] \[\e[1;91m\]$(__git_ps1 "(%s)")\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[1;0m\]"
fi


export PATH=$PATH:~/.local/bin/:~/.scripts

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
wallpaper=~/.config/wallpaper/obitoKakashi1.png
