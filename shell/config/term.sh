export DISABLE_AUTO_TITLE="true"
export AUTO_TITLE="false"

if [[ $TERM == xterm-termite ]] && [[ -f /etc/profile.d/vte/sh ]]; then
  source /etc/profile.d/vte.sh
  __vte_osc7
fi
