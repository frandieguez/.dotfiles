# Enable aliases to be sudo’ed
#alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"

# Git
alias g="git"
alias gaa="git add -A"
alias gaa="git add -A"
alias gb="git branch"
alias gb="git branch"
alias gc="$DOTLY_PATH/bin/dot git commit"
alias gca="git add --all && git commit --amend --no-edit"
alias gca="git add --all && git commit --amend --no-edit"
alias gcal=gcalcli
alias gco="git checkout"
alias gco="git checkout"
alias gd="$DOTLY_PATH/bin/dot git pretty-diff"
alias gf="git fetch --all -p"
alias gf="git fetch --all -p"
alias git-things-in-develop="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative master..develop --no-merges"
alias gl="$DOTLY_PATH/bin/dot git pretty-log"
alias gp="git push"
alias gpl="git pull --rebase --autostash"
alias gpl="git pull --rebase --autostash"
alias gpnv='git push --no-verify'
alias gps="git push"
alias gpsf="git push --force"
alias gpsf="git push --force"
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`' # git root
alias gs="git status -sb"
alias gs='git status -sb'

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias up='dot package update_all'

# Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
  alias o='open .'
else
  alias o="gio open"
fi
alias l="command eza --icons"


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

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

alias restartshell="exec $SHELL -l"
alias pullandmerge="git checkout $1; git pull --rebase; git merge --no-ff $2"

vmrss() {
  cat /proc/$1/status | grep VmRSS | cut -f2 -d: | xargs echo -n
}

alias kdes="kubectl config use-context situm-des-aks"
alias kpre="kubectl config use-context situm-pre-aks"
alias kpro="kubectl config use-context situm-pro-aks"

alias j="z"
## OS tools: provide functions that adapt to the current OS/distribution

# Helper to detect distro ID (returns empty if none)
detect_distro() {
  if [[ -e "/etc/os-release" ]]; then
    awk -F= '/^ID=/ {gsub(/"/, "", $2); print $2; exit}' /etc/os-release
  else
    echo ""
  fi
}

os_cleanup() {
  distro=$(detect_distro)
  if [[ -n "$distro" ]]; then
    case "$distro" in
    arch*)
      echo "== Limpiando sistema (Arch) =="
      sudo pacman -Rcns $(pacman -Qdtq) || echo "  ⚠️  'pacman -Rcns' falló o no había paquetes huérfanos"
      sudo pacman -Sc --noconfirm || echo "  ⚠️  'pacman -Sc' falló"
      if command -v yay >/dev/null 2>&1; then
        sudo yay -Sc --noconfirm || echo "  ⚠️  'yay -Sc' falló"
        rm -fr ~/.cache/yay || true
      fi
      sudo rm -f /var/lib/systemd/coredump/* || true
      sudo journalctl --vacuum-size=1M || true
      sudo rm -rf /var/cache/pacman/pkg/* || true
      ;;
    ubuntu|debian)
      echo "== Limpiando sistema (Ubuntu/Debian) =="
      sudo apt-get autoremove -y || echo "  ⚠️  'apt-get autoremove' falló"
      sudo apt-get clean || echo "  ⚠️  'apt-get clean' falló"
      ;;
    fedora)
      echo "== Limpiando sistema (Fedora) =="
      sudo dnf autoremove -y || echo "  ⚠️  'dnf autoremove' falló"
      sudo dnf clean all || echo "  ⚠️  'dnf clean all' falló"
      ;;
    *)
      echo "No hay una estrategia de limpieza para: $distro"
      ;;
    esac
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "== Limpiando sistema (macOS) =="
    if command -v brew >/dev/null 2>&1; then
      brew cleanup || echo "  ⚠️  'brew cleanup' falló"
    else
      echo "  ℹ️  Homebrew no está instalado; omitiendo."
    fi
  else
    echo "No se ha detectado una plataforma compatible para 'os_cleanup'."
  fi
}

os_upgrade() {
  distro=$(detect_distro)
  if [[ -n "$distro" ]]; then
    case "$distro" in
    arch*)
      echo "== Actualizando sistema (Arch) =="
      echo "1/5: Sincronizando repositorios y actualizando paquetes..."
      sudo pacman -Syyu --noconfirm || echo "  ⚠️  'pacman -Syyu' falló"

      echo "2/5: Actualizando AUR (si 'yay' o 'paru' existen)..."
      if command -v yay >/dev/null 2>&1; then
        yay -Syyua --noconfirm || echo "  ⚠️  'yay -Syyua' falló"
      elif command -v paru >/dev/null 2>&1; then
        paru -Syu --noconfirm || echo "  ⚠️  'paru -Syu' falló"
      else
        echo "  ℹ️  Ningún asistente AUR instalado; omitiendo paso AUR."
      fi

      echo "3/5: Actualizando flatpak/snap si están instalados..."
      if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y || echo "  ⚠️  'flatpak update' falló"
      fi
      if command -v snap >/dev/null 2>&1; then
        sudo snap refresh || echo "  ⚠️  'snap refresh' falló"
      fi

      echo "4/5: Eliminando paquetes huérfanos..."
      orphans=$(pacman -Qtdq 2>/dev/null)
      if [[ -n "$orphans" ]]; then
        sudo pacman -Rns --noconfirm $orphans || echo "  ⚠️  'pacman -Rns' falló"
      else
        echo "  ℹ️  No hay paquetes huérfanos."
      fi

      echo "5/5: Finalizando actualización Arch."
      ;;
    ubuntu|debian)
      echo "== Actualizando sistema (Ubuntu/Debian) =="
      echo "1/5: Actualizando índices de paquetes..."
      sudo apt-get update || echo "  ⚠️  'apt-get update' falló"

      echo "2/5: Actualizando paquetes instalados..."
      sudo apt-get dist-upgrade -y || echo "  ⚠️  'apt-get dist-upgrade' falló"

      echo "3/5: Actualizando snaps/flatpaks si están presentes..."
      if command -v snap >/dev/null 2>&1; then
        sudo snap refresh || echo "  ⚠️  'snap refresh' falló"
      fi
      if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y || echo "  ⚠️  'flatpak update' falló"
      fi

      echo "4/5: Eliminando paquetes huérfanos..."
      sudo apt-get autoremove -y || echo "  ⚠️  'apt-get autoremove' falló"

      echo "5/5: Limpiando caché de paquetes..."
      sudo apt-get autoclean -y || echo "  ⚠️  'apt-get autoclean' falló"
      ;;
    fedora)
      echo "== Actualizando sistema (Fedora) =="
      echo "1/4: Actualizando paquetes..."
      sudo dnf upgrade --refresh -y || echo "  ⚠️  'dnf upgrade' falló"

      echo "2/4: Actualizando snaps/flatpaks si están presentes..."
      if command -v snap >/dev/null 2>&1; then
        sudo snap refresh || echo "  ⚠️  'snap refresh' falló"
      fi
      if command -v flatpak >/dev/null 2>&1; then
        flatpak update -y || echo "  ⚠️  'flatpak update' falló"
      fi

      echo "3/4: Eliminando dependencias huérfanas..."
      sudo dnf autoremove -y || echo "  ⚠️  'dnf autoremove' falló"

      echo "4/4: Limpiando caché..."
      sudo dnf clean all || echo "  ⚠️  'dnf clean all' falló"
      ;;
    *)
      echo "No hay una estrategia de upgrade para: $distro"
      ;;
    esac
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "== Iniciando actualización del sistema (macOS) =="
    echo "1/6: Instalando actualizaciones de macOS (requiere sudo)..."
    if sudo softwareupdate -i -a; then
      echo "  ✅ Actualizaciones de macOS instaladas."
    else
      echo "  ⚠️  Falló la instalación de actualizaciones de macOS (revisar logs)."
    fi

    echo "2/6: Actualizando Homebrew..."
    if command -v brew >/dev/null 2>&1; then
      brew update || echo "  ⚠️  'brew update' falló"
    else
      echo "  ℹ️  Homebrew no está instalado; omitiendo pasos de Brew."
    fi

    echo "3/6: Actualizando fórmulas y casks de Homebrew..."
    if command -v brew >/dev/null 2>&1; then
      brew upgrade || echo "  ⚠️  'brew upgrade' falló"
    fi

    echo "4/6: Actualizando aplicaciones App Store con mas (si está instalado)..."
    if command -v mas >/dev/null 2>&1; then
      mas upgrade || echo "  ⚠️  'mas upgrade' falló"
    else
      echo "  ℹ️  'mas' no está instalado; omitiendo actualizaciones de App Store."
    fi

    echo "5/6: Eliminando paquetes de Homebrew no utilizados..."
    if command -v brew >/dev/null 2>&1; then
      brew autoremove || echo "  ⚠️  'brew autoremove' falló"
    fi

    echo "6/6: Limpieza final de Homebrew..."
    if command -v brew >/dev/null 2>&1; then
      brew cleanup || echo "  ⚠️  'brew cleanup' falló"
    fi

    echo "== Actualización macOS finalizada =="
  else
    echo "No se ha detectado una plataforma compatible para 'os_upgrade'."
  fi
}

# Backwards-compatible aliases
alias os-upgrade='os_upgrade'
alias os-cleanup='os_cleanup'
