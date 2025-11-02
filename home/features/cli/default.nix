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
    # Development Tools
    hledger
    puffin
    rclone
    alejandra
    basedpyright
    bat-extras.core
    black
    zathura
    cargo
    cmake
    colmena
    delta
    devenv
    duckdb
    dblab
    pgcli
    emacs
    ethtool
    systemctl-tui
    fish-lsp
    gcc
    gnumake
    go
    ispell
    lua
    lua-language-server
    luarocks
    maestral
    mathjax-node-cli
    mtr
    neovim
    nix-index
    nix-direnv
    nix-prefetch-github
    nix-output-monitor
    nodejs
    ntopng
    impala
    iwd
    nodejs_22
    poetry
    python314
    pipx
    stylua

    # System Utilities
    appimage-run
    bottom
    clipse
    coreutils
    docker
    docker-compose
    fd
    file
    fzf
    htop
    jq
    ncdu
    plocate
    procs
    progress
    ripgrep
    rsync
    trash-cli
    tree
    unzip
    wget
    which
    wl-clipboard
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
    yazi

    # Version Control
    lazygit

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
    atuin
    cheat
    comma
    direnv
    just
    tldr
    libtool
    libvterm
  ];
}
