# Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
  alias ls="command ls -G"
else
  alias ls="command ls --color"
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

alias -- -="cd -"
alias .....="cd ../../../.."
alias ....="cd ../../.."
alias ...="cd ../.."
alias ..="cd .."
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias be="bundle exec"
alias bye="exit"
alias c='pygmentize -O style=monokai -f console256 -g' # `cat` with beautiful colors. requires Pygments installed (sudo easy_install Pygments).
alias cd..="cd .."
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete" # Recursively delete `.DS_Store` files
alias current_date='date +%F\ %R'
alias debug='cat > /tmp/debug.html&&w3m /tmp/debug.html'
alias doctest='python -m doctest'
alias ducks="du -cks *|sort -rn | head"
alias e="$EDITOR"
alias fastping='ping -c 100 -s.2'
alias ff='find . -iname'
alias fs="stat -f \"%z bytes\"" # File size
alias g="git"
alias gaa="git add -A"
alias gb="git branch"
alias gca="git add --all && git commit --amend --no-edit"
alias gcal=gcalcli
alias gco="git checkout"
alias gf="git fetch --all -p"
alias git-things-in-develop="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative master..develop --no-merges"
alias gpl="git pull --rebase --autostash"
alias gpnv='git push --no-verify'
alias gp="git push"
alias gpsf="git push --force"
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # git root
alias gs='git status -sb'
alias hl='hamster list'
alias home='cd ~ && clear'
alias hosts='sudo $EDITOR /etc/hosts' # yes I occasionally 127.0.0.1 twitter.com ;)
alias hsa='hamster start'
alias hso='hamster stop'
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"" # View HTTP traffic
alias ip_solver="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias irssi='TERM=screen-256color irssi'
alias ks='tmux kill-session'
alias l="ls -l ${colorflag}"   # List all files colorized in long format
alias la="ls -la ${colorflag}" # List all files colorized in long format, including dot files
alias lsd='ls -l | grep "^d"'  # List only directories
alias maild="sudo python -c 'import smtpd, asyncore; smtpd.DebuggingServer((\"127.0.0.1\", 25), None); asyncore.loop()'"
alias map="xargs -n1"
alias mirror-update="sudo reflector --latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
alias music=ncmpcpp
alias mux="tmuxinator"
alias nf='neofetch --ascii ~/.neofetch --ascii_colors 18 25 39'
alias nis="npm install --save"
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias o="gio open"
alias path='echo -e ${PATH//:/\\n}'
alias pcat='pygmentize -O bg=dark'
alias please=sudo                          # be nice
alias plistbuddy="/usr/libexec/PlistBuddy" # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias ports='netstat -tulanp'
alias pt=papertrail
alias public_ip="curl ifconfig.me"
alias rot13='tr a-zA-Z n-za-mN-ZA-M' # ROT13-encode text. Works for decoding, too! ;)
alias s="subl3"
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'" # View HTTP traffic
alias t='tmux a||tmux new-s'
alias tailf="tail -f"
alias trimcopy="tr -d '\n' | pbcopy" # Trim new lines and copy to clipboard
alias v=$VIM
alias vh='vagrant halt'
alias vi=$VIM
alias vim=$VIM
alias vs='vagrant ssh'
alias vsus='vagrant suspend'
alias vu='vagrant up'
alias whois="whois -h whois-servers.net" # Enhanced WHOIS lookups
alias zr='source ~/.zshrc'
alias ~="cd ~" # `cd` is probably faster to type though
if [[ "$OSTYPE" == "linux-gnu" ]]; then alias open=xdg-open; fi
if [ -x "$(command -v thefuck)" ]; then alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'; fi

## pass options to free ##
alias meminfo='free -m -l -t'
function mem_per_proccess() {
  ps -eo size,pid,user,command --sort -size | awk '{ hr=$1/1024 ; printf("%13.2f Mb ",hr) } { for ( x=4 ; x<=NF ; x++ ) { printf("%s ",$x) } print "" }' | cut -d "" -f2 | cut -d "-" -f1
}

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# OS Upgrade aliases
if [[ ! -e "/etc/os-release" ]]; then
  echo "No os-release"
else
  distribution=$(cat /etc/os-release | grep "ID=" | cut -f2 -d"=")

  case "$distribution" in
  arch*)
    alias os-cleanup='sudo pacman -Rcns $(pacman -Qdtq); sudo pacman -Sc --noconfirm; sudo yay -Sc --noconfirm; sudo rm /var/lib/systemd/coredump/*; sudo journalctl --vacuum-size=1M; sudo rm -r /var/cache/pacman/pkg/*' # Cleans automatically installed deps
    alias os-upgrade='sudo pacman -Syuu; yay -Syyua --noconfirm; flatpak update;'
    alias pacman-disowned-dirs="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type d -print | sed 's/\([^/]\)$/\1\//' | sort -u ) <(pacman -Qlq | sort -u)" # Show dirs that don't belong to any package
    alias pacman-disowned-files="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type f -print | sort -u ) <(pacman -Qlq | sort -u)"                          # Show files that don't belong to any package:
    ;;
  ubuntu)
    alias os-cleanup='sudo apt-get autoremove; sudo apt-get clean'
    alias os-upgrade='sudo apt-get update; sudo apt-get dist-upgrade'
    ;;
  *)
    echo "No os-release compatible"
    ;;
  esac
fi

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

alias restartshell="exec $SHELL -l"
alias pullandmerge="git checkout $1; git pull --rebase; git merge --no-ff $2"

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open .'
alias up='dot package update_all'
