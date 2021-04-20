
# Set standard editor
export EDITOR=vi

alias vi='vim -p'

# Copy vim out to xclip
alias xp='cat ~/.vbuf | xclip -sel clip'

alias ll='ls -d */'
alias l='ls -lrth'

alias gs='git status'
alias gp='git push'
alias ga='git add'
alias gc='git commit -m'

# Add trash to rm
alias rm='trash'

# Functions
function take {
  mkdir $1
  cd $1
}

# Can't remmeber all the different extraction commands
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1 ;;
            *.tar.gz)    tar xvzf $1 ;;
            *.bz2)       bunzip2 $1 ;;
            *.rar)       unrar x $1 ;;
#            *.gz)        gunzip $1 ;;
            *.gz)        tar xvf $1 ;;
            *.tar)       tar xvf $1 ;;
            *.tbz2)      tar xvjf $1 ;;
            *.tgz)       tar xvzf $1 ;;
            *.zst)       tar -I zstd xvzf $1 ;;
            *.zip)       unzip $1 ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1 ;;
            *.tar.*)     tar xvf $1 ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

alias emoji_shrug='echo -n "¯\_(ツ)_/¯" | xclip -selection clipboard'
alias myip='echo $(curl -s https://api.ipify.org)'

# Force parallel to be on 1 thread
alias parallel="OMP_NUM_THREADS=1 parallel"

source $HOME/.bash_aliases.local
