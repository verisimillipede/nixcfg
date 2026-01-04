{pkgs, ...}: {
  imports = [
    ../../cli/fish.nix
    ../../cli/tmux.nix
  ];

  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      # enableFishIntegration = true;
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
    };
    bat = {
      enable = true;
    };
    atuin = {
      enable = true;
      enableFishIntegration = true;
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
  home.packages = with pkgs; [
    rclone
    tealdeer
    lazygit
    yazi
    file
    htop
    fzf
    ncdu
    ripgrep
    rsync
    trash-cli
    plocate
    tree
    which
    wl-clipboard
    docker
    docker-compose
    fd
    neovim
    systemctl-tui
    emacs
    plocate
    pipx
  ];
}
