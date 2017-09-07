# Load external configuration files
for file in ~/.config/shell/config/*; do
    source "$file"
done

for file in ~/.config/shell/functions/*; do
    source "$file"
done

if [ -f /etc/profile.d/vte.sh ]; then
  . /etc/profile.d/vte.sh
fi
