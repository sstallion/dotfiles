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

case `uname -s` in
Darwin)
	# Reattach to the per-user namespace to access the pasteboard.
	# For macOS Sierra, specify `--with-wrap-pbcopy-and-pbpaste`
	# when installing reattach-to-user-namespace via brew(1);
	# see: https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard,
	#      http://superuser.com/a/413233.
	tmux set-option -g default-command "reattach-to-user-namespace -l $SHELL"

	# Key Bindings
	tmux bind-key -t vi-copy Enter copy-pipe "pbcopy"
	tmux bind-key -t vi-copy y     copy-pipe "pbcopy"
	tmux bind-key ] run-shell "pbpaste | tmux load-buffer - && tmux paste-buffer"
	;;
Linux)
	# Disable terminal clipboard when using gnome-terminal;
	# see: http://askubuntu.com/a/507215.
	tmux set-option -g set-clipboard off

	# Key Bindings
	tmux bind-key -t vi-copy Enter copy-pipe "xsel -i -b"
	tmux bind-key -t vi-copy y     copy-pipe "xsel -i -b"
	tmux bind-key ] run-shell "xsel -o -b | tmux load-buffer - && tmux paste-buffer"
	;;
esac

# Enable mouse support:
if has_version 2.1; then
	tmux set-option -g mouse on
elif has_version 1.6; then
	tmux set-option -g mouse-mode on
	tmux set-option -g mouse-resize-pane on
	tmux set-option -g mouse-select-pane on
	tmux set-option -g mouse-select-window on
fi
exit 0
