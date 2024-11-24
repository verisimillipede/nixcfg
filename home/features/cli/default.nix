{pkgs, ...}: {
  programs = {
    zoxide = {
      enable = true;
      enablefishintegration = true;
    };
    eza = {
      enable = true;
      enablefishintegration = true;
      enablebashintegration = true;
      extraOptions = ["-l" "--icons" "-a" "--git"];
    };
    bat = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    alejandra
    bc
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
    zellij-ps
    zip
  ];
}
