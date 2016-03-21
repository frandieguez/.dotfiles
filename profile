# Load external configuration files
for file in ~/.shell/config/*; do
    source "$file"
done

for file in ~/.shell/functions/*; do
    source "$file"
done

if [ -f /etc/profile.d/vte.sh ]; then
  . /etc/profile.d/vte.sh
fi
