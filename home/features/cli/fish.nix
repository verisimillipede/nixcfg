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

      shellInit = ''
        set -U fish_greeting
        fish_add_path /home/mike/.local/bin
      '';

      interactiveShellInit = ''
        set -gx EDITOR nvim
        set -gx VISUAL nvim
        set -gx BROWSER zen-browser
        set -gx TERMINAL kitty
        set -gx HOME /home/mike
        set -gx XDG_CONFIG_HOME $HOME/.config
        set -gx MAIL $HOME/Mail
        set -U fish_key_bindings fish_vi_key_bindings
        bind -M insert \cp history-search-backward
        bind -M insert \cn history-search-forward
        bind \ce accept-autosuggestion
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
        mkdir = "mkdir -pv";
        grep = "rg";
        ps = "procs";
        fs = "du -ah . | sort -hr | head -n 10";

        # Bash Scripts
        sa = "bash ~/.bash-scripts/sort-artists.sh";
        ghr = "bash ~/.bash-scripts/git-remote-setup.sh";

        # System Commands
        locate = "sudo plocate";
        ping = "ping -c 5";

        # Nix Commands
        nr = "sudo nixos-rebuild switch --flake .#$hostname";
        hm = "home-manager switch --flake .#mike@$hostname";
        nu = "sudo nixos-rebuild switch --flake .#$hostname; and home-manager switch --flake .#mike@$hostname";
        nc = "cd ~/nixcfg; and nvim .";
        ni = "nix-instantiate --eval --strict";

        # Quick Access
        c = "clear";
        h = "history";
        b = "yazi";

        # Git Commands
        gs = "git status";
        gp = "git pull";
        ga = "git add";
        gc = "git commit -m \"{}\"";
        gco = "git checkout";
        gd = "git diff";
        gpa = "git push codeberg main && git push github main";
        lg = "lazygit";
        gr = "bash ~/.bash-scripts/git-remote-setup.sh";

        # Neovim/Editor Commands
        nv = "nvim .";
        ns = "nvim -S Session.vim";
        nxv = "nix run ~/dotfiles/nixvim";
        vi = "nvim";
        vim = "nvim";


        # Python & Virtual Environments
        p = "python";
        pm = "python main.py";


        # Directory Navigation
        "-" = "cd ..";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # Tailscale
        tsu = "sudo tailscale up";
        tsd = "sudo tailscale down";

        # Streamrip Commands
        fetch = {
          expansion = "rip search qobuz album '%'";
          setCursor = true;
        };
        tfetch = {
          expansion = "rip search tidal album '%'";
          setCursor = true;
        };
        fetchndb = {
          expansion = "rip -ndb search qobuz album '%'";
          setCursor = true;
        };
        tfetchndb = {
          expansion = "rip -ndb search tidal album '%'";
          setCursor = true;
        };

        # Software
        marvin = "appimage-run /opt/marvin/marvin.AppImage";
        zb = "appimage-run /opt/zen-browser/zen-x86_64.AppImage";
      };
    };
  };
}
