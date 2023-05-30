function cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function j() {
  fname=$(declare -f -F _z)

  [ -n "$fname" ] || source "$DOTLY_PATH/modules/z/z.sh"

  _z "$1"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

reverse-search() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail HIST_FIND_NO_DUPS 2> /dev/null

  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" fzf) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}

function print_colors() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

#!/bin/sh

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
	find . -name "$1"
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	open "http://localhost:${port}/"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# git log with per-commit cmd-clickable GitHub URLs (iTerm)
#function gf() {
#  local remote="$(git remote -v | awk '/^origin.*\(push\)$/ {print $2}')"
#  [[ "$remote" ]] || return
#  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
#  git log $* --name-status --color | awk "$(cat <<AWK
#    /^.*commit [0-9a-f]{40}/ {sha=substr(\$2,1,7)}
#    /^[MA]\t/ {printf "%s\thttps://github.com/$user_repo/blob/%s/%s\n", \$1, sha, \$2; next}
#    /.*/ {print \$0}
#AWK
#  )" | less -F
#}

# Copy w/ progress
cp_p() {
	rsync -WavP --human-readable --progress $1 $2
}

# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
function httpcompression() {
	encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}

# Syntax-highlight JSON strings or files
function json() {
	if [ -p /dev/stdin ]; then
		# piping, e.g. `echo '{"foo":42}' | json`
		python -mjson.tool | pygmentize -l javascript
	else
		# e.g. `json '{"foo":42}'`
		python -mjson.tool <<<"$*" | pygmentize -l javascript
	fi
}

# take this repo and copy it to somewhere else minus the .git stuff.
function gitexport() {
	mkdir -p "$1"
	git archive master | tar -x -C "$1"
}

# get gzipped size
function gz() {
	echo "orig size    (bytes): "
	cat "$1" | wc -c
	echo "gzipped size (bytes): "
	gzip -c "$1" | wc -c
}

# All the dig info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

# Escape UTF-8 characters into their 3-byte format
function escape() {
	printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
	echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
	echo # newline
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
	if [[ -n "$1" ]]; then
		if [[ $2 == '--good' ]]; then
			ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
			time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - >$1.gif
			rm out-static*.png
		else
			ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 >$1.gif
		fi
	else
		echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
	fi
}

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	alias pbcopy='wl-copy'
	alias pbpaste='wl-paste'
	#alias pbcopy='xclip -selection clipboard'
	#alias pbpaste='xclip -selection clipboard -o'
fi

# Kills the program that matches the name provided as first argument
function killthis() {
	ps auxx | grep $1 | tr -s " " | cut -f 2 -d" " | head -1 | xargs kill -9
}

function vol() {
  volume=$(((65536 * $1 + 99) / 100))

  pacmd set-sink-volume 0 $volume
}
