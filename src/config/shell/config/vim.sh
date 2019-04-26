# Set the vim runtime for nvim
if [ -x "$(command -v nvim)" ]; then
    export VIMRUNTIME=$(find /usr/share -type d -name runtime 2> /dev/null|grep nvim |head -1)
fi
