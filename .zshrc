export ZSH=$HOME/.zsh.d
export ZSH_THEME="default"

# Load and run compinit
autoload -U compinit
compinit -i

# History
source $ZSH/history.zsh

# Completions
source $ZSH/completion.zsh

# Aliases
source $ZSH/aliases.zsh

# Extra key bindings
source $ZSH/key-bindings.zsh

# Color spectrum fixes
source $ZSH/spectrum.zsh

# Not sure about this one, check it
source $ZSH/termsupport.zsh

# Color theme support
source $ZSH/theme.zsh

# Git hax
source $ZSH/git.zsh

# Theme
if [ ! "$ZSH_THEME" = ""  ]
then
  if [ -f "$ZSH/custom/$ZSH_THEME.zsh-theme" ]
  then
    source "$ZSH/custom/$ZSH_THEME.zsh-theme"
  else
    source "$ZSH/themes/$ZSH_THEME.zsh-theme"
  fi
fi

export TERM=xterm-256color
export LC_CTYPE=""
export PAGER=less
export EDITOR=emacs

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

setopt long_list_jobs

export PATH=$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin
export PYTHONPATH=/usr/local/lib/python2.7/site-packages/:$PYTHONPATH

export REPORTTIME=30

export TMPDIR=/tmp

eval "$(rbenv init -)"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
