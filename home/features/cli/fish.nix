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
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
      loginShellInit = ''
        set fish_greeting ""
        # Include original PATH components
        set PATH $PATH /home/mike/.local/bin /usr/bin /usr/local/bin /usr/local/sbin /home/mike/.local/share/nvim/mason/bin /home/mike/.local/share/nvim/mason/packages/python-lsp-server/venv/bin
        # Add pipx binary path
        set PATH $PATH $HOME/.local/bin

        # Environment Variables
        set -x EDITOR nvim
        set -x VISUAL nvim
        set -x BROWSER zen-browser
        set -x TERMINAL kitty
        set -x SHELL /etc/profiles/per-user/mike/bin/fish
        set -x HOME /home/mike
        set -x XDG_CONFIG_HOME $HOME/.config
        set -x PIPX_HOME $HOME/.local/pipx
        set -x PIPX_BIN_DIR $HOME/.local/bin

        # Nix Path
        set NIX_PATH /home/mike/dotfiles/nixos/configuration.nix
      '';
      shellAbbrs = {
        # List Directory Contents
        ls = "eza";
        ll = "eza -l --icons --git -a";
        la = "eza -a";
        lt = "eza --tree --level=2 --long --icons --git";

        # File Operations
        cat = "bat";
        cp = "cp -v";
        mv = "mv -v";
        rm = "rm -%";
        mkdir = "mkdir -pv";
        grep = "rg";
        ps = "procs";
        fs = "du -ah . | sort -hr | head -n 10";

        # System Commands
        locate = "sudo plocate";
        ping = "ping -c 5";

        # Nix Commands
        nr = "sudo nixos-rebuild switch --flake .#zenbook";
        hm = "home-manager switch --flake .#mike@zenbook";
        ni = "nix-instantiate --eval --strict";

        # Quick Access
        c = "clear";
        h = "history";
        b = "yazi";

        # Git Commands
        gs = "git status";
        gp = "git pull";
        ga = "git add";
        gc = "git commit -m '%'";
        gco = "git checkout";
        gd = "git diff";
        gpa = "git push codeberg main && git push github main";
        lg = "lazygit";

        # Neovim/Editor Commands
        nv = "nvim .";
        vi = "nvim";
        vim = "nvim";

        # SSH
        prawn = "ssh prawn@chappie";

        # Python & Virtual Environments
        p = "python";
        pm = "python main.py";


        # Directory Navigation
        "-" = "cd ..";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # Streamrip
        fetch = "rip search qobuz album '%'";
        tfetch = "rip search tidal album '%'";
        fetchndb = "rip -ndb search qobuz album '%'";
        tfetchndb = "rip -ndb search tidal album '%'";

        # Tailscale
        tsu = "sudo tailscale up";
        tsd = "sudo tailscale down";
      };
    };
  };
}
