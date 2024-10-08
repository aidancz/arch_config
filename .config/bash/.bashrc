# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ source
source "$HOME/.shrc"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ prompt
# PS1="(\$ \u \h \w) "
# PS1="\e[1m(\$ \u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \h \w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \e[32m\h \e[34m\w) \e[0m"
# PS1="\e[1m(\e[31m\$ \e[33m\u \e[32m\h \e[34m\w\e[39m) \e[0m"
# PS1="\[\e[1m\](\[\e[31m\]\$ \[\e[33m\]\u \[\e[32m\]\h \[\e[34m\]\W\[\e[39m\]) \[\e[0m\]"

PS1="(\$ \u \h \W) "

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ map
# https://stackoverflow.com/questions/8366450/complex-keybinding-in-bash
# https://stackoverflow.com/questions/4200800/in-bash-how-do-i-bind-a-function-key-to-a-command

bind -m vi-insert  -x '"\eOP":setsid -f $TERMINAL >/dev/null 2>&1'
bind -m vi-command -x '"\eOP":setsid -f $TERMINAL >/dev/null 2>&1'
# \eOP is keycode for function key f1

bind -m vi-insert  '"\eOQ":"\ecc\C-d"'
bind -m vi-command '"\eOQ":"\ecc\C-d"'
# \eOQ is keycode for function key f2

# bind -m vi-insert  '"\ef":"\ecccd $(dirname $(fzf))\n"'
# bind -m vi-command '"\ef":"\ecccd $(dirname $(fzf))\n"'
# # \ef is keycode for alt-f

# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ lfcd
# # lfcd () {
# lfubcd () {
#     tmp="$(mktemp -uq)"
#     trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
#     # lf -last-dir-path="$tmp" "$@"
#     lfub -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
# bind -m vi-insert  '"\eOR":"\ecclfubcd\n"'
# bind -m vi-command '"\eOR":"\ecclfubcd\n"'
# # \eOR is keycode for function key f3
# # \e cc lfubcd \n

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ yy
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
bind -m vi-insert  '"\eOR":"\eccyy\n"'
bind -m vi-command '"\eOR":"\eccyy\n"'
# \eOR is keycode for function key f3
# \e cc yy \n

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ official shell integration
eval "$(zoxide init bash --no-cmd)"
alias e='__zoxide_z'
alias ei='__zoxide_zi'

function fzf_cd() {
	local path
	path=$(fzf +m -q "$1")
	if [ -d "$path" ]; then
		path="$path"
	else
		path=$(dirname "$path")
	fi
	cd "$path"
}
alias i='fzf_cd'
