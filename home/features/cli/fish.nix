{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.fish;
in {
  options.features.cli.fish.enable = mkEnableOption "enable fish shell";
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      loginShellInit = ''
        set fish_greeting ""
        # Include original PATH components
        set PATH $PATH /home/mike/.local/bin /usr/bin /usr/local/bin /usr/local/sbin /home/mike/.local/share/nvim/mason/bin /home/mike/.local/share/nvim/mason/packages/python-lsp-server/venv/bin
        # Add pipx binary path
        set PATH $PATH $HOME/.local/bin
        fish_vi_key_bindings
        set -x BROWSER zen-browser
        set -x TERMINAL kitty
        set -x EDITOR nvim
        set -x VISUAL zed
        set -x XDG_DATA_HOME $HOME/.local/share
        # Add any pipx-specific environment variables if needed
        set -x PIPX_HOME $HOME/.local/pipx
        set -x PIPX_BIN_DIR $HOME/.local/bin
      '';
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../..";
        b = "yazi";
        ls = "eza";
        la = "eza -a";
        ll = "eza -l --icons --git -a";
        lt = "eza --tree --level=2 --long --icons --git";
        grep = "rg";
        ps = "procs";
        fs = "du -ah . | sort -hr | head -n 10";
        cat = "bat";
        cp = "cp -v";
        mv = "mv -v";
        mkdir = "mkdir -pv";
        tsu = "sudo tailscale up";
        tsd = "sudo tailscale down";
        nv = "nvim .";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
