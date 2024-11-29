{ config, lib, pkgs, ... }:
with lib;
let
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
        pkgs.tmux-modal
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
      '';
    };
  };
}
