{pkgs, ...}: {
  imports = [
    ./fish.nix
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
    alacritty
    alejandra
    atuin
    bc
    bottom
    comma
    coreutils
    devenv
    direnv
    doing
    fabric-ai
    fd
    gcc
    go
    htop
    httpie
    jq
    just
    lf
    lazygit
    ncdu
    netcat
    nix-index
    nix-direnv
    nix-output-monitor
    plocate
    procs
    progress
    ripgrep
    tldr
    tmux
    trash-cli
    unimatrix
    unzip
    wttrbar
    wireguard-tools
    yazi
    zip
  ];
}
