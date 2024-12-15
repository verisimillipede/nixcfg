{ pkgs, ...}: {
  imports = [
    ./home.nix
    ../features/cli
    ../common
  ];

  home.packages = with pkgs; [
    appimage-run
    cowsay
    fd
    fzf
    htop
    kitty
    lazygit
    ncdu
    netcat
    neovim
    plocate
    ripgrep
    rsync
    tldr
    tmux
    tree
    unimatrix
    unzip
    which
    yazi
    zip
  ];
  # features.cli = {
  #   fish.enable = true;
  #   tmux.enable = true;
  # };
}
