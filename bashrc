stty stop undef
stty start undef

# Author godlygeek from #vim @freenode
# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal)
{
  [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && {
    if ldd /proc/$PPID/exe | grep libvte; then
      if [ "`tput -Tgnome-256color colors`" = "256" ]; then
        TERM=gnome-256color
      elif [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color
      elif tput -T gnome; then
        TERM=gnome
      fi
    fi
  }
} >/dev/null 2>/dev/null

# Check for an interactive session
[ -z "$PS1" ] && return

# Regular aliases
alias mim='ssh -x az306487@students.mimuw.edu.pl'
alias mimvnc='vncviewer students.mimuw.edu.pl:3'

# Color output
alias ls='ls --color=auto'
alias pacman='pacman-color'
alias grep='grep -n --color=auto'
# Less coloring
export LESSCOLOR="yes"
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '
# Dir colors - setting are in /etc/dircolors
eval `dircolors -b ~/.console_env/dircolors_config`
# Color manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Lovely prompt when in git repository
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

# export PS1='\e[1;32m[\u@\e[1;34m\h \e[1;34m\W]\e[1;35m$(parse_git_branch)\e[0m $ '
function _update_ps1()
{
	export PS1="$(~/.console_env/powerline-bash.py $?)"
}

export PROMPT_COMMAND="_update_ps1"

PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/adek/.local/bin
PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/adek/.local/bin:/home/adek/.local/bin

# Bash history
HISTCONTROL=ignoredups

# E.g. for svn
export SVN_EDITOR=vim

# Make "g++" command call colorgcc
export PATH="/usr/lib/colorgcc/bin:$PATH"

# Tell ccache to invoke compilers in /usr/bin
export CCACHE_PATH="/usr/bin"

# Mim account
export MIM=az306487@students.mimuw.edu.pl

# Django stuff
# export DJANGO_SETTINGS_MODULE=mysite.settings
