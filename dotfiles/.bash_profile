#!/bin/bash

# Platform-specific setups
unamestr=$(uname)
case $unamestr in
  'Linux')
    if command -v keychain ; then
      keychain id_rsa
      . ~/.keychain/`uname -n`-sh
    fi
esac

if command -v vimless ; then
  export PAGER=vimless
fi

alias less=$PAGER

if command -v vimman ; then
  export MANPAGER=vimman
fi

# enable vi command line editing mode
#set -o vi

# shortcut to vim
alias :e=vim

# add path to all my useful script and binary directories
export PATH=$HOME/bin:$HOME/xbin:$PATH

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# load up my git-enabled prompt
source git_prompt

# load up bash completion scripts from other people
source git-completion.bash
source git-flow-completion.bash

# searches for given string in filenames in current and all subdirectories
function s { find . -nowarn -name "*$1*" 2>/dev/null; }
# searches for given filename exactly in current and all subdirectories
function ss { find . -nowarn -name "$1" 2>/dev/null; }

# ls with showall, colors, and /'s after directories
alias ls="ls -AFhxX --color --group-directories-first "
alias ll='ls -alF'
alias lk="ls -gGhLXS"
alias la='ls -A'
alias l='ls -CF'

# makes sure bash knows it's dealing with a color terminal-emulator and sets the colors for ls
# LSCOLORS is BSD/OSX format, LS_COLORS is linux format
export CLICOLOR=1

# grep customizations
alias grep='grep -Hns --binary-files=without-match --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
function gr { grep -R $1 $2./*; }
function grr { grep -R $*; }

function rg { find . -name '*.*rb' -exec grep "$*" {} \; -print; }

# diff with unified format (why use anything else?!)
alias diff='diff -U3'

# Add an "alert" alias for long running commands. Use semicolor to execute it in sequence
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# replace this with a util that allows real directory history navigation
alias cx='pushd'
alias cz='popd'

# prints out the ps header and then displays all processes matching the given argument
function psg { ps -A | awk 'NR==1; /'$1'/&&!/awk/'; }

# spell checker
function spell { echo $@|aspell -a; }

# sooo many letters to type in a day, here's a few less for the history command
alias h='history'
# bash history shit, removes dups, increases size, and saves on shell exit
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Load RVM if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Adding CDE specific aliases
alias cde='cd ~/Projects/Corndog'
alias config='cd ~/Projects/config'
alias gs='git status'
