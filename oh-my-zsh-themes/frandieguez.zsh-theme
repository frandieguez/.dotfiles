# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
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

if [[ -e /etc/bash_completion.d/git-prompt ]] then
  source '/etc/bash_completion.d/git-prompt'
fi

# check whether printf supports -v
__git_printf_supports_v=
printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
  local key value
  local svn_remote svn_url_pattern count n
  local upstream=git legacy="" verbose="" name=""

  svn_remote=()
  # get some config options from git-config
  local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
  while read -r key value; do
    case "$key" in
    bash.showupstream)
      GIT_PS1_SHOWUPSTREAM="$value"
      if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
        p=""
        return
      fi
      ;;
    svn-remote.*.url)
      svn_remote[$((${#svn_remote[@]} + 1))]="$value"
      svn_url_pattern="$svn_url_pattern\\|$value"
      upstream=svn+git # default upstream is SVN if available, else git
      ;;
    esac
  done <<< "$output"

  # parse configuration values
  for option in ${GIT_PS1_SHOWUPSTREAM}; do
    case "$option" in
    git|svn) upstream="$option" ;;
    verbose) verbose=1 ;;
    legacy)  legacy=1  ;;
    name)    name=1 ;;
    esac
  done

  # Find our upstream
  case "$upstream" in
  git)    upstream="@{upstream}" ;;
  svn*)
    # get the upstream from the "git-svn-id: ..." in a commit message
    # (git-svn uses essentially the same procedure internally)
    local -a svn_upstream
    svn_upstream=($(git log --first-parent -1 \
          --grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
    if [[ 0 -ne ${#svn_upstream[@]} ]]; then
      svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
      svn_upstream=${svn_upstream%@*}
      local n_stop="${#svn_remote[@]}"
      for ((n=1; n <= n_stop; n++)); do
        svn_upstream=${svn_upstream#${svn_remote[$n]}}
      done

      if [[ -z "$svn_upstream" ]]; then
        # default branch name for checkouts with no layout:
        upstream=${GIT_SVN_ID:-git-svn}
      else
        upstream=${svn_upstream#/}
      fi
    elif [[ "svn+git" = "$upstream" ]]; then
      upstream="@{upstream}"
    fi
    ;;
  esac

  # Find how many commits we are ahead/behind our upstream
  if [[ -z "$legacy" ]]; then
    count="$(git rev-list --count --left-right \
        "$upstream"...HEAD 2>/dev/null)"
  else
    # produce equivalent output to --count for older versions of git
    local commits
    if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
    then
      local commit behind=0 ahead=0
      for commit in $commits
      do
        case "$commit" in
        "<"*) ((behind++)) ;;
        *)    ((ahead++))  ;;
        esac
      done
      count="$behind  $ahead"
    else
      count=""
    fi
  fi

  # calculate the result
  if [[ -z "$verbose" ]]; then
    case "$count" in
    "") # no upstream
      p="" ;;
    "0  0") # equal to upstream
      p="=" ;;
    "0  "*) # ahead of upstream
      p=">" ;;
    *"  0") # behind upstream
      p="<" ;;
    *)      # diverged from upstream
      p="<>" ;;
    esac
  else
    case "$count" in
    "") # no upstream
      p="" ;;
    "0  0") # equal to upstream
      p=" u=" ;;
    "0  "*) # ahead of upstream
      p=" u+${count#0 }" ;;
    *"  0") # behind upstream
      p=" u-${count%  0}" ;;
    *)      # diverged from upstream
      p=" u+${count#* }-${count%  *}" ;;
    esac
    if [[ -n "$count" && -n "$name" ]]; then
      __git_ps1_upstream_name=$(git rev-parse \
        --abbrev-ref "$upstream" 2>/dev/null)
      if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
        p="$p \${__git_ps1_upstream_name}"
      else
        p="$p ${__git_ps1_upstream_name}"
        # not needed anymore; keep user's
        # environment clean
        unset __git_ps1_upstream_name
      fi
    fi
  fi

}

# Helper function that is meant to be called from __git_ps1.  It
# injects color codes into the appropriate gitstring variables used
# to build a gitstring.
__git_ps1_colorize_gitstring ()
{
  if [[ -n ${ZSH_VERSION-} ]]; then
    local c_red='%F{red}'
    local c_green='%F{green}'
    local c_lblue='%F{blue}'
    local c_clear='%f'
  else
    # Using \[ and \] around colors is necessary to prevent
    # issues with command line editing/browsing/completion!
    local c_red='\[\e[31m\]'
    local c_green='\[\e[32m\]'
    local c_lblue='\[\e[1;34m\]'
    local c_clear='\[\e[0m\]'
  fi
  local bad_color=$c_red
  local ok_color=$c_green
  local flags_color="$c_lblue"

  local branch_color=""
  if [ $detached = no ]; then
    branch_color="$ok_color"
  else
    branch_color="$bad_color"
  fi
  c="$branch_color$c"

  z="$c_clear$z"
  if [ "$w" = "*" ]; then
    w="$bad_color$w"
  fi
  if [ -n "$i" ]; then
    i="$ok_color$i"
  fi
  if [ -n "$s" ]; then
    s="$flags_color$s"
  fi
  if [ -n "$u" ]; then
    u="$bad_color$u"
  fi
  r="$c_clear$r"
}

__git_eread ()
{
  local f="$1"
  shift
  test -r "$f" && read "$@" <"$f"
}

# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt (includes branch name)
#
# __git_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
# when two arguments are given, the first is prepended and the second appended
# to the state string when assigned to PS1.
# The optional third parameter will be used as printf format string to further
# customize the output of the git-status string.
# In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
__git_ps1 ()
{
  # preserve exit status
  local exit=$?
  local pcmode=no
  local detached=no
  local ps1pc_start='\u@\h:\w '
  local ps1pc_end='\$ '
  local printf_format=' (%s)'

  case "$#" in
    2|3)  pcmode=yes
      ps1pc_start="$1"
      ps1pc_end="$2"
      printf_format="${3:-$printf_format}"
      # set PS1 to a plain prompt so that we can
      # simply return early if the prompt should not
      # be decorated
      PS1="$ps1pc_start$ps1pc_end"
    ;;
    0|1)  printf_format="${1:-$printf_format}"
    ;;
    *)  return $exit
    ;;
  esac

  # ps1_expanded:  This variable is set to 'yes' if the shell
  # subjects the value of PS1 to parameter expansion:
  #
  #   * bash does unless the promptvars option is disabled
  #   * zsh does not unless the PROMPT_SUBST option is set
  #   * POSIX shells always do
  #
  # If the shell would expand the contents of PS1 when drawing
  # the prompt, a raw ref name must not be included in PS1.
  # This protects the user from arbitrary code execution via
  # specially crafted ref names.  For example, a ref named
  # 'refs/heads/$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' might cause the
  # shell to execute 'sudo rm -rf /' when the prompt is drawn.
  #
  # Instead, the ref name should be placed in a separate global
  # variable (in the __git_ps1_* namespace to avoid colliding
  # with the user's environment) and that variable should be
  # referenced from PS1.  For example:
  #
  #     __git_ps1_foo=$(do_something_to_get_ref_name)
  #     PS1="...stuff...\${__git_ps1_foo}...stuff..."
  #
  # If the shell does not expand the contents of PS1, the raw
  # ref name must be included in PS1.
  #
  # The value of this variable is only relevant when in pcmode.
  #
  # Assume that the shell follows the POSIX specification and
  # expands PS1 unless determined otherwise.  (This is more
  # likely to be correct if the user has a non-bash, non-zsh
  # shell and safer than the alternative if the assumption is
  # incorrect.)
  #
  local ps1_expanded=yes
  [ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
  [ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=no

  local repo_info rev_parse_exit_code
  repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
    --is-bare-repository --is-inside-work-tree \
    --short HEAD 2>/dev/null)"
  rev_parse_exit_code="$?"

  if [ -z "$repo_info" ]; then
    return $exit
  fi

  local short_sha
  if [ "$rev_parse_exit_code" = "0" ]; then
    short_sha="${repo_info##*$'\n'}"
    repo_info="${repo_info%$'\n'*}"
  fi
  local inside_worktree="${repo_info##*$'\n'}"
  repo_info="${repo_info%$'\n'*}"
  local bare_repo="${repo_info##*$'\n'}"
  repo_info="${repo_info%$'\n'*}"
  local inside_gitdir="${repo_info##*$'\n'}"
  local g="${repo_info%$'\n'*}"

  if [ "true" = "$inside_worktree" ] &&
     [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
     [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
     git check-ignore -q .
  then
    return $exit
  fi

  local r=""
  local b=""
  local step=""
  local total=""
  if [ -d "$g/rebase-merge" ]; then
    __git_eread "$g/rebase-merge/head-name" b
    __git_eread "$g/rebase-merge/msgnum" step
    __git_eread "$g/rebase-merge/end" total
    if [ -f "$g/rebase-merge/interactive" ]; then
      r="|REBASE-i"
    else
      r="|REBASE-m"
    fi
  else
    if [ -d "$g/rebase-apply" ]; then
      __git_eread "$g/rebase-apply/next" step
      __git_eread "$g/rebase-apply/last" total
      if [ -f "$g/rebase-apply/rebasing" ]; then
        __git_eread "$g/rebase-apply/head-name" b
        r="|REBASE"
      elif [ -f "$g/rebase-apply/applying" ]; then
        r="|AM"
      else
        r="|AM/REBASE"
      fi
    elif [ -f "$g/MERGE_HEAD" ]; then
      r="|MERGING"
    elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
      r="|CHERRY-PICKING"
    elif [ -f "$g/REVERT_HEAD" ]; then
      r="|REVERTING"
    elif [ -f "$g/BISECT_LOG" ]; then
      r="|BISECTING"
    fi

    if [ -n "$b" ]; then
      :
    elif [ -h "$g/HEAD" ]; then
      # symlink symbolic ref
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      local head=""
      if ! __git_eread "$g/HEAD" head; then
        return $exit
      fi
      # is it a symbolic ref?
      b="${head#ref: }"
      if [ "$head" = "$b" ]; then
        detached=yes
        b="$(
        case "${GIT_PS1_DESCRIBE_STYLE-}" in
        (contains)
          git describe --contains HEAD ;;
        (branch)
          git describe --contains --all HEAD ;;
        (describe)
          git describe HEAD ;;
        (* | default)
          git describe --tags --exact-match HEAD ;;
        esac 2>/dev/null)" ||

        b="$short_sha..."
        b="($b)"
      fi
    fi
  fi

  if [ -n "$step" ] && [ -n "$total" ]; then
    r="$r $step/$total"
  fi

  local w=""
  local i=""
  local s=""
  local u=""
  local c=""
  local p=""

  if [ "true" = "$inside_gitdir" ]; then
    if [ "true" = "$bare_repo" ]; then
      c="BARE:"
    else
      b="GIT_DIR!"
    fi
  elif [ "true" = "$inside_worktree" ]; then
    if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
       [ "$(git config --bool bash.showDirtyState)" != "false" ]
    then
      git diff --no-ext-diff --quiet --exit-code || w="*"
      if [ -n "$short_sha" ]; then
        git diff-index --cached --quiet HEAD -- || i="+"
      else
        i="#"
      fi
    fi
    if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
       git rev-parse --verify --quiet refs/stash >/dev/null
    then
      s="$"
    fi

    if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
       [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
       git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
    then
      u="%${ZSH_VERSION+%}"
    fi

    if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
      __git_ps1_show_upstream
    fi
  fi

  local z="${GIT_PS1_STATESEPARATOR-" "}"

  # NO color option unless in PROMPT_COMMAND mode
  if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
    __git_ps1_colorize_gitstring
  fi

  b=${b##refs/heads/}
  if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
    __git_ps1_branch_name=$b
    b="\${__git_ps1_branch_name}"
  fi

  local f="$w$i$s$u"
  local gitstring="$c$b${f:+$z}$r$p"

  if [ $pcmode = yes ]; then
    if [ "${__git_printf_supports_v-}" != yes ]; then
      gitstring=$(printf -- "$printf_format" "$gitstring")
    else
      printf -v gitstring -- "$printf_format" "$gitstring"
    fi
    PS1="$ps1pc_start$gitstring$ps1pc_end"
  else
    printf -- "$printf_format" "$gitstring"
  fi

  return $exit
}

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
  SEGMENT_SEPARATOR=$'\ue0b0' # 
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
    echo -n " %{%k%F{$CURRENT_BG}%}\n$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black yellow "%(!.%{%F{yellow}%}.)$USER@%m:"
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
      # prompt_segment black yellow
    # else
      prompt_segment black green
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
        prompt_segment red white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_segment green black
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment red black
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment yellow black
        st='±'
      else
        prompt_segment green black
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  # prompt_segment black blue '%~'
  prompt_segment black magenta '%c' # print only the short dir name
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
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

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}
promt_current_time() {
  prompt_segment black blue '%*'
}

## Main prompt
build_prompt() {
  RETVAL=$?
  promt_current_time
  echo -n " "
  prompt_status
  prompt_virtualenv
  prompt_context
  prompt_dir
  prompt_git
  prompt_hg
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
