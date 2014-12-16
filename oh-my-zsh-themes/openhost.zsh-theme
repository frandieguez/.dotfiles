# vim:ft=zsh ts=2 sw=2 sts=2
# ZSH Theme - Preview: http://
#
source '/etc/bash_completion.d/git-prompt'

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWDIRTYSTATE
export GIT_PS1_SHOWSTASHSTATE
export GIT_PS1_SHOWUNTRACKEDFILES
export GIT_PS1_SHOWUPSTREAM

local current_time="%(?.%{$fg[blue]%}.%{$fg[red]%})%*%{$reset_color%}"
local user_host='%{$fg[yellow]%}%n@%m%{$reset_color%}'
local current_dir='%{$fg[magenta]%}%c%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='%{$fg[green]%}$(__git_ps1 "[%s]") %{$reset_color%}'
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT="${current_time} ${user_host}:${current_dir}${rvm_ruby} ${git_branch}
%B$%b "
RPS1="${return_code}"
