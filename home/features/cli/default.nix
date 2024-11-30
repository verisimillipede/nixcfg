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
    alacritty
    alejandra
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
    direnv
    fabric-ai
    fastfetch
    fd
    file
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
    nextcloud30
    ncdu
    netcat
    neomutt
    neovim
    nix-index
    nix-direnv
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
