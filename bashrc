# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

## Derived from default Ubuntu, jdub's config, and some of my own 
## stuff I figured out along the way

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f ~/dotfiles/private/bash_myinfo ];then
    . ~/dotfiles/private/bash_myinfo
fi
export MAIL="~/.maildir/"
export EDITOR="vim"

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# enable color support of ls and also add handy aliases
# but let's do it in a cool way so that it works nice on
# the Mac too!
if [ "$TERM" != "dumb" ]; then
    case $OSTYPE in
    linux*)
                if [ -x /usr/bin/figlet-toilet ];then
                        figlet-toilet -S -f small --gay $USER@$HOSTNAME
                elif [ -x /usr/bin/figlet ];then
                        figlet -S -f small $HOSTNAME
                fi
        echo -e "Setting up Linux environment...\c"
        export DEBEMAIL=$EMAIL

# make less more friendly for non-text input files, see lesspipe(1)
		[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
		if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
		    debian_chroot=$(cat /etc/debian_chroot)
		fi
		;;

    darwin*)
# Setup brew environment first, then echo hostname
        PATH=/usr/local/bin:/usr/local/sbin:$PATH
        if [ -d $(brew --prefix)/bin ]; then
# if brew is installed then check for figlet 
        	if [ -x $(brew --prefix)/bin/figlet ]; then
        	figlet -S -f small $HOSTNAME
        	fi
        echo "Setting up OS X Environment..."
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
            if [ -f $(brew --prefix)/etc/bash_completion ]; then
                . $(brew --prefix)/etc/bash_completion
                echo -e "Setting up bash completion for this shell...\c"
            else
                echo "no bash_completion in this shell"
            fi

# setup DISPLAY variable for apple's Terminal.app and other dumb term progs
# since we cant run Terminal.app from ssh, no need to check $SSH_* stuff        
#        elif [[ $TERM_PROGRAM == Apple_Terminal ]]; then
#            if [ -f ~/.xdisplayrc ];then
#                echo "setting \$DISPLAY from ~/.xdisplayrc"
#                . ~/.xdisplayrc
#            else
#                echo "no ~/.xdisplayrc found. Fix it!"
#            fi
        fi
        ;;
        *)
    ;;
    esac
fi

# My Silly Prompt (which I think is really rather handy)
# I used Jeff's checks on $DISPLAY but this did not work from OS X 
# clients that werent running X11.app. Now I just check to see if were 
# running in ssh or not.

#if [ -z $DISPLAY ] || [ "$DISPLAY" = ":0.0" ] || [ "$DISPLAY" = ":1.0" ] || [ ! -z $SSH_CLIENT ];
if [[ -z $SSH_CLIENT ]];
then
        # Local
    	COLOR1="\[\033[0;32m\]"
        COLOR2="\[\033[0;36m\]"
        COLOR3="\[\033[0;37m\]"
else
        # Remote connection
        COLOR1="\[\033[0;36m\]"
        COLOR2="\[\033[0;32m\]"
        COLOR3="\[\033[0;37m\]"
fi

if [ "$UID" = "0" ];
then
        # I am root
        COLOR1="\[\033[0;31m\]"
fi

export PS1="\n$COLOR1\T \h:$COLOR2 \w\n\$ $COLOR3"


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|gnome*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
*)
        ;;
esac

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/dotfiles/bash_aliases ]; then
    . ~/dotfiles/bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#elif 
#	[ -f $(brew --prefix)/etc/bash_completion ]; then
#    . $(brew --prefix)/etc/bash_completion
#fi

# Bring in my cool programs that do nifty stuff
if [ -d ~/bin ]; then
        PATH=$PATH:~/bin
fi

# If this is Pangaea then bring in my config for that environment
#if [ -f ~/.bashrc.pangaea ]; then
#		. ~/.bashrc.pangaea
#fi
