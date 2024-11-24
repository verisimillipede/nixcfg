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
        set -g fish_greeting
        fish_vi_key_bindings
        set -x TERMINAL kitty
        set -x EDITOR nvim
        set -x VISUAL zed
        set -x XDG_DATA_HOME $HOME/.local/share
        set -x FZF_CTRL_R_OPTS "
        --preview='bat --color=always -n {}'
        --preview-window up:3:hidden:wrap
        --bind 'ctrl-/:toggle-preview'
        --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
        --color header:bold
        --header 'Press CTRL-Y to copy command into clipboard'"
        set -x FZF_DEFAULT_COMMAND fd --type f --exclude .git --follow --hidden
        set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
      '';
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../..";
        b = "yazi";
        ls = "eza";
        l = "eza -l --icons --git -a";
        lt = "eza --tree --level=2 --long --icons --git";
        grep = "rg";
        ps = "procs";
        just = "just --unstable";
        fs = "du -ah . | sort -hr | head -n 10";

        # n = "nix";
        # nd = "nix develop -c $SHELL";
        # ns = "nix shell";
        # nsn = "nix shell nixpkgs#";
        # nb = "nix build";
        # nbn = "nix build nixpkgs#";
        # nf = "nix flake";

        # nr = "sudo nixos-rebuild --flake .";
        # nrs = "sudo nixos-rebuild switch --flake .#(uname -n)";
        # snr = "sudo nixos-rebuild --flake .";
        # snrs = "sudo nixos-rebuild --flake . switch";
        # hm = "home-manager --flake .";
        # hms = "home-manager --flake . switch";
        # hmr = "cd ~/projects/nix-configurations; nix flake lock --update-input dotfiles; home-manager --flake .#(whoami)@(hostname) switch";

        tsu = "sudo tailscale up";
        tsd = "sudo tailscale down";

        nv = "nvim .";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
