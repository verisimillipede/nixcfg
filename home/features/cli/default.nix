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
    alejandra
    basedpyright
    black
    cargo
    cmake
    colmena
    devenv
    duckdb
    emacs
    fish-lsp
    gcc
    gnumake
    go
    ispell
    lua
    lua-language-server
    luarocks
    maestral
    neovim
    nix-index
    nix-direnv
    nix-prefetch-github
    nix-output-monitor
    nodejs
    nodejs_22
    poetry
    python312
    python312Packages.numpy
    python312Packages.pip
    python3
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
    nnn
    pandoc
    yazi

    # Version Control
    lazygit

    # CLI Applications
    aider-chat
    calcurse
    neomutt
    taskwarrior3
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
