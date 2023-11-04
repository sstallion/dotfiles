# catppuccin.tmux - tmux colours based on Catppuccin Mocha

set-option -g message-command-style bg="#cba6f7",fg="#181825"
set-option -g message-style bg="#cba6f7",fg="#181825"

set-option -g status-style bg="#181825",fg="#cdd6f4"

set-window-option -g mode-style bg="#89b4fa",fg="#181825"

set-window-option -g pane-active-border-style fg="#181825"
set-window-option -g pane-border-style fg="#181825"

# Emulate lightline statusline style:
set-window-option -g window-status-current-format "#[fg=#181825,bg=#89b4fa]#[fg=#181825,bold,bg=#89b4fa] #I #W #[fg=#89b4fa,nobold,bg=#181825]"
set-window-option -g window-status-format "#[fg=#181825,bg=#181825]#[default] #I #W #[fg=#181825,bg=#181825]"
set-window-option -g window-status-separator ''

# vim: ft=tmux
