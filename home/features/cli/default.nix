{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./starship.nix
  ];

  programs = {
    zoxide = {
      enable = true;
      enableFishIntegration = true;
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
  };

  home.packages = with pkgs; [
    alejandra
    bc
    netcat
    comma
    coreutils
    devenv
    direnv
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
    nix-index
    nix-direnv
    nix-output-monitor
    procs
    progress
    ripgrep
    tldr
    trash-cli
    unimatrix
    unzip
    wttrbar
    wireguard-tools
    yazi
    zip
  ];
}
