{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./tmux.nix
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
    asciiquarium
    alacritty
    alejandra
    appimage-run
    atuin
    bc
    bottom
    calcurse
    cargo
    cheat
    cmake
    comma
    cowsay
    coreutils
    curl
    devenv
    docker
    docker-compose
    direnv
    fabric-ai
    fastfetch
    fd
    file
    freetube
    fzf
    gcc
    go
    htop
    httpie
    jq
    just
    kitty
    lf
    lazygit
    libxfs
    mapscii
    ncdu
    netcat
    neomutt
    neovim
    nix-index
    nix-direnv
    nix-prefetch-github
    nix-output-monitor
    nnn
    nmap
    nyancat
    plocate
    procs
    progress
    p7zip
    ripgrep
    rsync
    taskwarrior3
    thefuck
    tldr
    tmux
    trash-cli
    tree
    unimatrix
    unzip
    which
    wireguard-tools
    wofi
    wttrbar
    xz
    yazi
    zip
  ];
}
