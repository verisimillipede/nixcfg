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
    aider-chat
    asciiquarium
    alacritty
    alejandra
    appimage-run
    atuin
    # bambu-studio
    basedpyright
    bc
    black
    bottom
    calcurse
    cargo
    cheat
    cmake
    comma
    cowsay
    coreutils
    curl
    cups
    devenv
    docker
    docker-compose
    direnv
    fabric-ai
    fastfetch
    fd
    file
    fish-lsp
    freetube
    fzf
    gcc
    go
    htop
    httpie
    apacheHttpd
    jq
    just
    kitty
    lf
    lazygit
    lua-language-server
    libxfs
    mpv
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
    syncthing
    taskwarrior3
    thefuck
    tldr
    tmux
    trash-cli
    tree
    unimatrix
    unzip
    wget
    which
    wireguard-tools
    wofi
    wttrbar
    xz
    yazi
    yt-dlp
    zip
  ];
}
