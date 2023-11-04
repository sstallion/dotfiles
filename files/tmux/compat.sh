#!/bin/sh -x
# compat.sh - tmux compatibility

# tmux does a terrible job integrating with the underlying operating
# system, especially when it is executing in a graphical environment.
# To add insult to injury, backward compatibility is not maintained for
# options, which change meaning between versions. This script attempts
# to bridge this divide so a common tmux.conf can be used on different
# systems running different versions without issue.

has_version() {
	[ -z "$version" ] && version=`tmux -V | cut -c 6-`
	return `echo $@ | awk "{print (($version >= \$1) == 0)}"`
}

is_remote() {
	test -n "$SSH_CONNECTION"
}

case `uname -s` in
Darwin)
	# Reattach to the per-user namespace to access the pasteboard.
	# For macOS Sierra, specify `--with-wrap-pbcopy-and-pbpaste`
	# when installing reattach-to-user-namespace via brew(1);
	# see: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard,
	#      http://superuser.com/a/413233.
	tmux set-option -g default-command "reattach-to-user-namespace -l $SHELL"

	# Key Bindings
	if has_version 2.4; then
		tmux bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"
		tmux bind-key -T copy-mode-vi y     send-keys -X copy-pipe-and-cancel "pbcopy"
	else
		tmux bind-key -t vi-copy Enter copy-pipe "pbcopy"
		tmux bind-key -t vi-copy y     copy-pipe "pbcopy"
	fi
	tmux bind-key ] run-shell "pbpaste | tmux load-buffer - && tmux paste-buffer"
	;;
*)
	# Disable terminal clipboard when using gnome-terminal;
	# see: http://askubuntu.com/a/507215.
	tmux set-option -g set-clipboard off

	# Experimental support for (unidirectional) clipboard sharing;
	# requires a forwarded TCP port on the remote machine:
	if is_remote; then
		copy_command="nc -N localhost 5555"
		paste_command=
	else
		copy_command="xsel -i -b"
		paste_command="xsel -o -b"
	fi

	# Key Bindings
	if has_version 2.4; then
		tmux bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "$copy_command"
		tmux bind-key -T copy-mode-vi y     send-keys -X copy-pipe-and-cancel "$copy_command"
	else
		tmux bind-key -t vi-copy Enter copy-pipe "$copy_command"
		tmux bind-key -t vi-copy y     copy-pipe "$copy_command"
	fi

	[ -n "$paste_command" ] &&
		tmux bind-key ] run-shell "$paste_command | tmux load-buffer - && tmux paste-buffer"
	;;
esac

# True Color
if has_version 3.2; then
	set-option -ag terminal-overrides ",xterm-256color:RGB"
fi

# Key Bindings
if has_version 2.4; then
	tmux bind-key -T copy-mode-vi C-j    send-keys -X page-down
	tmux bind-key -T copy-mode-vi C-k    send-keys -X page-up

	tmux bind-key -T copy-mode-vi Escape send-keys -X cancel
	tmux bind-key -T copy-mode-vi v      send-keys -X begin-selection
else
	bind-key -t vi-copy C-j    page-down
	bind-key -t vi-copy C-k    page-up

	bind-key -t vi-copy Escape cancel
	bind-key -t vi-copy v      begin-selection
fi

# Focus Support
if has_version 1.9; then
	tmux set-option -g focus-events on
fi

# Mouse Support
if has_version 2.1; then
	tmux set-option -g mouse on
elif has_version 1.6; then
	tmux set-option -g mouse-mode on
	tmux set-option -g mouse-resize-pane on
	tmux set-option -g mouse-select-pane on
	tmux set-option -g mouse-select-window on
fi
exit 0
