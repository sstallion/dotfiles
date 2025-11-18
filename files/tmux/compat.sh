#!/bin/sh
# compat.sh - tmux compatibility

set -o xtrace

# tmux does a terrible job integrating with the underlying operating
# system, especially when it is executing in a graphical environment.
# To add insult to injury, backward compatibility is not maintained for
# options, which change meaning between versions. This script attempts
# to bridge this divide so a common tmux.conf can be used on different
# systems running different versions without issue.

has_version() {
	[ -z "${version}" ] && version=$(tmux -V | cut -c 6-)
	return $(echo $@ | awk "{print ((${version} >= \$1) == 0)}")
}

is_remote() {
	test -n "${SSH_CONNECTION}"
}

case "$(uname -s)" in
Darwin)
	# Reattach to the per-user namespace to access the pasteboard.
	# For macOS Sierra, specify `--with-wrap-pbcopy-and-pbpaste`
	# when installing reattach-to-user-namespace via brew(1);
	# see: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard,
	#      http://superuser.com/a/413233.
        if ! has_version 2.6; then
            tmux set-option -g default-command "reattach-to-user-namespace -l ${SHELL}"
        fi

	# Key Bindings
	tmux bind-key -T copy-mode-vi Enter             send-keys -X copy-pipe-and-cancel "pbcopy"
	tmux bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-no-clear   "pbcopy"
	tmux bind-key -T copy-mode-vi y                 send-keys -X copy-pipe-and-cancel "pbcopy"
	tmux bind-key ] run-shell "pbpaste | tmux load-buffer - && tmux paste-buffer"
	;;
*)
	# Disable terminal clipboard when using gnome-terminal;
	# see: https://github.com/tmux/tmux/wiki/Clipboard#terminal-support---vte-terminals.
	tmux set-option -g set-clipboard off

	# Experimental support for (unidirectional) clipboard sharing;
	# requires a forwarded TCP port on the remote machine:
	if is_remote; then
		copy_command="socat - TCP:127.0.0.1:5494"
		paste_command=
	else
		copy_command="xsel -i -b"
		paste_command="xsel -o -b"
	fi

	# Key Bindings
	tmux bind-key -T copy-mode-vi Enter             send-keys -X copy-pipe-and-cancel "${copy_command}"
	tmux bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-no-clear   "${copy_command}"
	tmux bind-key -T copy-mode-vi y                 send-keys -X copy-pipe-and-cancel "${copy_command}"

	[ -n "${paste_command}" ] &&
		tmux bind-key ] run-shell "${paste_command} | tmux load-buffer - && tmux paste-buffer"
	;;
esac

# True Color
if has_version 3.2; then
	tmux set-option -ag terminal-overrides ",*-256color:RGB"
else
	tmux set-option -ag terminal-overrides ",*-256color:Tc"
fi

# Key Bindings
tmux bind-key -T copy-mode-vi C-j    send-keys -X page-down
tmux bind-key -T copy-mode-vi C-k    send-keys -X page-up

tmux bind-key -T copy-mode-vi Escape send-keys -X cancel
tmux bind-key -T copy-mode-vi v      send-keys -X begin-selection

# Focus Support
tmux set-option -g focus-events on

# Mouse Support
tmux set-option -g mouse on
tmux unbind-key -n MouseDrag1Border
exit 0
