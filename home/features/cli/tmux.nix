{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.tmux;
in {
  options.features.cli.tmux = {
    enable = mkEnableOption "tmux configuration";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      disableConfirmationPrompt = true;
      keyMode = "vi";
      prefix = "C-a";
      terminal = "screen-256color";
      plugins = with pkgs.tmuxPlugins; [
        copycat
        extrakto
        fuzzback
        nord
        prefix-highlight
        tmux-fzf
        # pkgs.tmux-modal
        vim-tmux-navigator
      ];
      extraConfig = ''
                set -g detach-on-destroy off             # When destory switch to the prev session
                set -ga terminal-overrides ",*256col*:Tc"
                set -g default-shell $SHELL              # use default shell
                set -sg escape-time 5                    # delay shorter
                set -g display-time 3000
                set -sg history-limit 100000             # increase scrollback
                set -g mouse on                          # enable mouse mode
                # source-file ~/.config/tmux/conf/keybindings.conf
                # left status is only length of 10
                set -g status-left-length 50
                # Enter prefix mode easily
                unbind C-b
                set -g prefix C-Space
                bind C-Space send-prefix

                set -g base-index 1 # Start windows and panes at 1
                set -g pane-base-index 1 # Start panes at 1
                set -g renumber-windows on # Reorder window numbers when a window is closed

                # Double tap space to switch to last window
                bind Space last-window

                # Cycle through windows with Alt + Space
                bind-key -n M-Space next-window

                # Go to specific windows with Alt + number
                bind-key -n M-1 select-window -t 1
                bind-key -n M-2 select-window -t 2
                bind-key -n M-3 select-window -t 3
                bind-key -n M-4 select-window -t 4
                bind-key -n M-5 select-window -t 5

                # Restoring clear screen with prefix + l
                bind C-l send-keys 'C-l'


                bind-key S set-option -g status
                set-option -g status-position top
                # Split windows
                bind | split-window -h
                bind - split-window -v

                # Pane resizing
                bind -n S-Up resize-pane -U 2
                bind -n S-Down resize-pane -D 2
                bind -n S-Left resize-pane -L 2
                bind -n S-Right resize-pane -R 2


                # Copy text
                setw -g mode-keys vi
                bind -T copy-mode-vi v send -X begin-selection
                bind -T copy-mode-vi y send -X copy-selection-and-cancel

                # # TODO: Do i need this?
                # # Copy to system clipboard
                # bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

                # Enlarge pane to display over entire window
                bind z resize-pane -Z

                # Better pane selection in prefix
                # bind -n C-/ display-panes

                # Create new window (both with and without prefix)
                bind c new-window
                bind-key -n M-t new-window

                # Refresh 'status-left' and 'status-right' more often, from every 15s to 5s
                set -g status-interval 5


        # Emacs key bindings in tmux command prompt (prefix + :) are better than
        # vi keys, even for vim users
                set -g status-keys emacs

        # Unbind escape key from root config
                unbind-key -T root Escape

        # Yazi file manager
                set -g allow-passthrough all
                set -ga update-environment TERM
                set -ga update-environment TERM_PROGRAM

      '';
    };
  };
}
