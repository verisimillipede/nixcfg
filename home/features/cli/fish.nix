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
        rm = "rm {}";
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
        gc = "git commit -m \"{}\"";
        gco = "git checkout";
        gd = "git diff";
        gpa = "git push codeberg main && git push github main";
        lg = "lazygit";

        # Neovim/Editor Commands
        nv = "nvim .";
        ns = "nvim -S Session.vim";
        nxv = "nix run ~/dotfiles/nixvim";
        vi = "nvim";
        vim = "nvim";

        # SSH
        prawn = "ssh prawn@chappie";
        zilla = "ssh zilla@mothra";
        toad = "ssh toad@archlinux";

        # Python & Virtual Environments
        p = "python";
        pm = "python main.py";
        d = "deactivate";
        ev = "source (poetry env info --path)/bin/activate.fish";

        # Project Directories
        zz = "cd ~/Projects/Zealot; nix-shell --run 'cd ~/Projects/Zealot/Zealot; exec fish'";

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
      };
    };
  };
}
