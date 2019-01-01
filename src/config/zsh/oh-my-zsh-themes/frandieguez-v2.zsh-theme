# vim:ft=zsh ts=2 sw=2 sts=2
#
# frandieguez's Theme - https://gist.github.com/3712874
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
# Make sure you have a recent version: the code points that Powerline
# uses changed in 2012, and older versions will display incorrectly,
# in confusing ways.
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.
if [ ! -f ~/.git-prompt.sh ]; then
  echo "Downloading git prompt script"
  curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
fi

source ~/.git-prompt.sh

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  # NOTE: This segment separator character is correct.  In 2012, Powerline changed
  # the code points they use for their special characters. This is the new code point.
  # If this is not working for you, you probably have an old version of the
  # Powerline-patched fonts installed. Download and install the new version.
  # Do not submit PRs to change this unless you have reviewed the Powerline code point
  # history and have new information.
  # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
  # what font the user is viewing this source code in. Do not replace the
  # escape sequence with a single literal character.
  #  SEGMENT_SEPARATOR=$'\ue0b0' # 
  SEGMENT_SEPARATOR=' '
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}\n"
  else
    echo -n "%{%k%}"
  fi
  echo -n "$%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment default yellow "$USER@%m:"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  # GIT_PS1_SHOWUPSTREAM
  # GIT_PS1_HIDE_IF_PWD_IGNORED
  # GIT_PS1_SHOWCOLORHINTS
  # GIT_PS1_DESCRIBE_STYLE
  # GIT_PS1_SHOWDIRTYSTATE
  # GIT_PS1_SHOWSTASHSTATE
  # GIT_PS1_SHOWUNTRACKEDFILES
  # GIT_PS1_SHOWUPSTREAM
  # GIT_PS1_STATESEPARATOR

  export GIT_PS1_SHOWDIRTYSTATE=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWUPSTREAM="auto"

  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0' # 
  }

  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    # echo $dirty
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    # if [[ -n $dirty ]]; then
      # p'rompt_segment black yellow
    # else
      prompt_segment default green
    # fi
    # echo -n "$PL_BRANCH_CHAR $(__git_ps1) ${mode}"
    echo -n "$(__git_ps1) ${mode}"

    # if [[ -e "${repo_path}/BISECT_LOG" ]]; then
    #   mode=" <B>"
    # elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
    #   mode=" >M<"
    # elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
    #   mode=" >R>"
    # fi

    # setopt promptsubst
    # autoload -Uz vcs_info

    # zstyle ':vcs_info:*' enable git
    # zstyle ':vcs_info:*' get-revision true
    # zstyle ':vcs_info:*' check-for-changes true
    # zstyle ':vcs_info:*' stagedstr ' ✚'
    # zstyle ':vcs_info:git:*' unstagedstr ' ●'
    # zstyle ':vcs_info:*' formats ' %u%c'
    # zstyle ':vcs_info:*' actionformats ' %u%c'
    # vcs_info
    # echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment default red
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment default yellow
        st='±'
      else
        # if working copy is clean
        prompt_segment default green
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment red default
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment yellow default
        st='±'
      else
        prompt_segment green default
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  # prompt_segment black blue '%~'
  prompt_segment default magenta '%c' # print only the short dir name
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment default black "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && echo -n "$symbols "
}
promt_current_time() {
  prompt_segment default cyan '%*'
}

prompt_return_code() {
# prompt_segment red default "%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
  echo -n "%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  promt_current_time
  echo -n " "
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
}

RPS1="$(prompt_return_code)"
PROMPT='%{%f%b%k%}$(build_prompt) '

