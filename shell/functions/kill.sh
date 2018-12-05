# Kills the program that matches the name provided as first argument
function killthis() {
    ps auxx|grep $1|tr -s " "|cut -f 2 -d" "|head -1|xargs kill -9
}
