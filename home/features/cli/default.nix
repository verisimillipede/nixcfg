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

    # Development Tools
    hledger
    puffin
    cmake
    alejandra
    basedpyright
    bat-extras.core
    black
    zathura
    cargo
    colmena
    delta
    devenv
    # duckdb
    # dblab
    pgcli
    ethtool
    fish-lsp
    gcc
    gnumake
    gnuplot
    go
    ispell
    lua
    lua-language-server
    luarocks
    maestral
    mathjax-node-cli
    nix-index
    # nix-direnv
    nix-prefetch-github
    nix-output-monitor
    nodejs
    # ntopng
    impala
    iwd
    # nodejs_22
    # poetry
    python314
    pipx
    stylua

    # System Utilities
    appimage-run
    bottom
    clipse
    coreutils
    jq
    procs
    progress
    unzip
    wget
    xz
    zip
    p7zip

    # Network Tools
    curl
    httpie
    nmap
    wireguard-tools

    # File Management
    exiftool
    lf
    pandoc

    # Version Control

    # CLI Applications
    # aider-chat
    calcurse
    neomutt
    tokei
    yt-dlp

    # System Monitoring
    fastfetch
    wttrbar

    # Fun CLI Tools
    asciiquarium
    cowsay
    nyancat
    sl
    unimatrix

    # Additional Tools
    cheat
    comma
    just
    # tldr
    libtool
    libvterm
  ];
}
