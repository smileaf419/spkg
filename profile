# Begin /etc/profile
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# modifications by Dagmar d'Surreal <rivyqntzne@pbzpnfg.arg>

# System wide environment variables and startup programs.

# System wide aliases and functions should go in /etc/bashrc.  Personal
# environment variables and startup programs should go into
# ~/.bash_profile.  Personal aliases and functions should go into
# ~/.bashrc.

# Functions to help us manage paths.  Second argument is the name of the
# path variable to be modified (default: PATH)
pathremove () {
        local IFS=':'
        local NEWPATH
        local DIR
        local PATHVARIABLE=${2:-PATH}
        for DIR in ${!PATHVARIABLE} ; do
                if [ "$DIR" != "$1" ] ; then
                  NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
                fi
        done
        export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
        pathremove $1 $2
        local PATHVARIABLE=${2:-PATH}
        export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
        pathremove $1 $2
        local PATHVARIABLE=${2:-PATH}
        export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

#export -f pathremove pathprepend pathappend

# Set the initial paths
export PATH=/bin:/usr/bin
export LD_LIBRARY_PATH=/lib:/lib64:/usr/lib:/usr/lib64

if [ $EUID -eq 0 ] ; then
        pathappend /usr/sbin
        pathappend /sbin
#        unset HISTFILE
fi

# Setup some environment variables.
export HISTSIZE=1000
#export HISTIGNORE="&:[bf]g:exit"

# Set some defaults for graphical systems
export XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/share/}
export XDG_CONFIG_DIRS=${XDG_CONFIG_DIRS:-/etc/xdg/}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/tmp/xdg-$USER}

export PKG_CONFIG_PATH=/lib/pkgconfig:/lib64/pkgconfig:/usr/lib/pkgconfig:/usr/lib64/pkgconfig

# Setup a red prompt for root and a green one for users.
NORMAL="\[$(tput sgr0)\]"
RED="\[$(tput setaf 196)\]"
PINK="\[$(tput setaf 201)\]"
BLUE="\[$(tput setaf 27)\]"
GREEN="\[$(tput setaf 82)\]"
DIM="\[$(tput dim)\]"
if [[ $EUID == 0 ]] ; then
	PS1="[$DIM\t$NORMAL] $RED\u@\h:$BLUE\w$RED# $NORMAL"
else
	PS1="[$DIM\t$NORMAL] $GREEN\u@\h:$BLUE\w$GREEN\$ $NORMAL"
#	PS1="[$DIM\t$NORMAL] $PINK\u@\h:$BLUE\w$PINK\$ $NORMAL"
fi
## Add a title default
PS1="\[\e]0;\u@\h - \w\a\]$PS1"

for script in /etc/profile.d/*.sh ; do
        if [ -r $script ] ; then
                . $script
        fi
done

unset script RED GREEN NORMAL PINK BLUE DIM

# End /etc/profile
