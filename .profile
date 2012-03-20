# Mike Mayer's Preferences
export TERM=xterm-256color
export PS1="[\033[30;1m\u@\@ \W\e]2;\w\a\033[0m]\n=: "
export EDITOR="mate"

alias ls="ls -G"
alias ll="ls -Ghla"
alias pico="mate"
alias nano="mate"

#set the number of open files to 1024
ulimit -S -n 1024
 


##
# Your previous /Users/mikem/.profile file was backed up as /Users/mikem/.profile.macports-saved_2012-03-05_at_20:38:49
##

# MacPorts Installer addition on 2012-03-05_at_20:38:49: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

