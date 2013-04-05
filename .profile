export TERM=xterm-256color
export CLICOLOR=1

# Sublime Text
# ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
# http://www.sublimetext.com/docs/2/osx_command_line.html
export EDITOR="subl -w"

#Aliases
alias nano="subl"
alias pico="subl"
alias ls="ls -G"
alias ll="ls -Ghla"

ulimit -S -n 1024
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
launchctl setenv PATH $PATH

set completion-ignore-case on
set mark-symlinked-directories on

#coolguy prompt stuff

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	c_reset='\[\e[0m\]'
	c_user='\[\033[36m\]'
	c_path='\[\e[0;33m\]'
	c_git_clean='\[\e[0;32m\]'
	c_git_dirty='\[\e[0;35m\]'
	c_split='\[\e[1;30m\]'
else
	c_reset=
	c_user=
	c_path=
	c_git_clean=
	c_git_dirty=
	c_split=
fi

c_arrow=' > '


#http://stackoverflow.com/a/2658301/360143
function evil_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

arrow() {
	echo '$c_arrow'
	return 0
}


git_prompt () {
	if ! git rev-parse --git-dir > /dev/null 2>&1; then
		tabname '\w'
		return 0
	fi

	git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')	

	if git diff --quiet 2>/dev/null >&2; then
		echo " [$c_git_clean$git_branch${c_reset}]"
		tabname '\w'
	else
		echo " {$c_git_dirty$git_branch${c_reset}}"
		tabname '\w ✶'
	fi
	
	winname '\w'
}

function tabname {
  printf "\e]1;$1\a"
}
 
function winname {
  printf "\e]2;$1\a"
}

PROMPT_COMMAND='PS1="${c_split}(${c_user}\T${c_reset}${c_split}:${c_path}\w${c_split})${c_reset}$(git_prompt)\n${c_split}$(arrow)${c_reset} "'
