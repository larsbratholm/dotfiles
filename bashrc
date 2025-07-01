# Preserve bash history in multiple terminal windows
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE='ls:bf:fg:history:l:sound:dock:undock:headphones:top:l:mocp:rm'
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Save and reload the history after each command finishes
export PROMPT_COMMAND='history -a'
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# all my aliases
if test -f ~/.bash_aliases; then . ~/.bash_aliases; fi

# bash completion
if test -f /etc/bash_completion; then . /etc/bash_completion; fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Start ssh agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" &>/dev/null

# Pip installed packages
if test -d "$HOME/.local/bin"; then export PATH="$HOME/.local/bin:$PATH"; fi

# Global bins
if test -d "/opt/bin"; then PATH="/opt/bin:$PATH"; fi
if test -d "/opt/sbin"; then PATH="/opt/sbin:$PATH"; fi
if test -d "/snap/bin"; then PATH="/snap/bin:$PATH"; fi

# My own bins
if test -d "$HOME/bin"; then PATH="$HOME/bin:$PATH"; fi
if test -d "$HOME/bin.x"; then PATH="$HOME/bin.x:$PATH"; fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# If this is on interactive node, change color
if test ! -z $JOB_ID; then
    export PS1="$Red\h $Cyan\W$Color_Off"
fi




# Don't send me messages
mesg n

if test -f $HOME/.bashrc.local; then source $HOME/.bashrc.local; fi

# Setup conda generally
if test -d "$HOME/opt/conda"; then
    CONDA_PREFIX="$HOME/opt/conda"
    __conda_setup="$('$CONDA_PREFIX/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_PREFIX/etc/profile.d/conda.sh" ]; then
            . "$CONDA_PREFIX/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_PREFIX/bin:$PATH"
        fi
    fi
    unset __conda_setup
    #Activate
    conda activate base
fi

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

export PS1="$Blue\h$Color_Off $Cyan\W$Color_Off"

# If this is on interactive node, change color
if test ! -z $JOB_ID; then
    export PS1="$Red\h $Cyan\W$Color_Off"
fi

if [ -z "$PS1NOGIT" ]
then
export PS1="$PS1"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "'$Green'"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "'$Red'"$(__git_ps1 " {%s}"); \
  fi)"; \
fi)'

fi

export PS1=$PS1"$Color_Off \$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
    ;;
*)
    ;;
esac
