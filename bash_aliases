#Super handy alias for using a bare repo like the cool kids
# Thanks DistroTube – https://youtu.be/tBoLDpTWVOM
# Thanks https://www.atlassian.com/git/tutorials/dotfiles
# Will have to adjust location of git depending on host
alias config='git --git-dir=$HOME/Repos/dotfiles/ --work-tree=$HOME'

# useful du output
alias usage='du -csh *'

# ALL HOSTS
###########################################################

# Get the weather
#alias wetter="curl wttr.in/Saint-Gallen"
alias wetter="curl wttr.in/st.gallen?lang=de"

wttr()
{
    # change to your default location
    local request="wttr.in/${1-Saint-Gallen}"
    [ "$(tput cols)" -lt 125 ] && request+='?n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

#alias gmail="elinks https://mail.google.com/"

# See, I make this mistake so often, I may as well make the damn thing work.
# If only it worked for form submittal in Mozilla...
alias :q!="exit"
alias :wq="exit"
alias :q="exit"
alias :Q="exit"
alias sduo="sudo"
alias c="clear"
alias m="more"

# some ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

#alias l="ls"
#alias la="ls -A"
#alias dir='ls --color=auto --format=vertical'
#alias vdir='ls --color=auto --format=long'

# I dont setup VIM this naughty way anymore. Using ~/dotfiles instead
#alias setup_vim="mkdir -p ~/.vim/{colors,doc,ftplugin,plugin,syntax} ~/.vim_{backup,temp}"

# I use procmail, and find these very handy for handling mailstat. Usually
# mailstat removes your procmail log, so I have "nm" which does that, "nmk"
# which keeps it intact (so your logs keep adding up) and "om" which shows
# a the previous mailstat from a saved procmail log.
#alias nm="mailstat -m ~/.maildir/procmail.log"
#alias nmk="mailstat -mk ~/.maildir/procmail.log"
#alias om="mailstat -om ~/.maildir/procmail.log"

# LINUX HOSTS
###########################################################
case $OSTYPE in
linux*)
# enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
        alias bterm="xterm -bg rgb:78/62/41"
        alias logmail="tail -F /var/log/mail.log"
        fi

# make less more pretty
        alias less="/usr/share/vim/vimcurrent/macros/less.sh"

## Ubuntu packaging and bug hunting helpers
        alias addme2apt="gpg --armor --export F97AE9DF | sudo apt-key add -"
        alias dpkg-buildpackage="dpkg-buildpackage -kF97AE9DF -rfakeroot"
        alias desktopabsolute="grep -E "^Icon=\/usr\/" \
        /usr/share/applications/*.desktop | cut -d: -f1 | xargs dlocate"
        alias checkinstall="sudo checkinstall \
        --maintainer=sepheenix@rabbitnet.org --nodoc --delspec=yes"

# Cool vlc text movie
        alias vlctext="vlc -I rc -V caca"

        ;;

# OS X HOSTS
###########################################################
darwin*)
# make less more pretty
        alias less='/usr/share/vim/vim80/macros/less.sh'

        ;;
*)
        ;;
esac

## A few cool functions

## Print my configs for bug-squashing sans all my cruddy comments
printconf()
{
        cat $1 |grep -v ^# |grep [:alnum:]
}

## AWESOME SHELL FUNCTIONS
# Very Important Shell Function taken from jdub
beer()
{
        echo "         _.._..,_,_"
        echo "        (          )"
        echo "         ]~,\"-.-~~["
        echo "       .=])' (;  ([    PANTS OFF!"
        echo "       | ]:: '    ["
        echo "       '=]): .)  (["
        echo "         |:: '    |"
        echo "          ~~----~~"
}
