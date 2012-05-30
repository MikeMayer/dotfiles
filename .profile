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
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
launchctl setenv PATH $PATH

set completion-ignore-case on
set mark-symlinked-directories on

# git magic
# Inspired by https://gist.github.com/828432

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

#http://stackoverflow.com/a/2658301/360143
function evil_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

git_prompt ()
{
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

PROMPT_COMMAND='PS1="${c_split}(${c_user}\u${c_reset}${c_split}@${c_user}\T${c_reset}${c_split}:${c_path}\w${c_split})${c_reset}$(git_prompt)\n${c_split}\$${c_reset} "'
