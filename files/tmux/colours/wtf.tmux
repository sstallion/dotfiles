# wtf.tmux - tmux colours based on Whiskey Tango Focus

set-option -g message-command-style bg=colour5
set-option -g message-style bg=colour5

set-option -g status-style bg=colour234

set-window-option -g mode-style bg=colour12,fg=colour234

set-window-option -g pane-active-border-style fg=colour8
set-window-option -g pane-border-style fg=colour8

# Emulate lightline statusline style:
set-window-option -g window-status-current-format "#[fg=colour234,bg=colour4]#[fg=colour15,bold,bg=colour4] #I #W #[fg=colour4,nobold,bg=colour234]"
set-window-option -g window-status-format "#[fg=colour234,bg=colour234]#[default] #I #W #[fg=colour234,bg=colour234"
set-window-option -g window-status-separator ''

# vim: ft=tmux
