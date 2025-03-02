{ pkgs, inputs, system, ... }: {
  home.packages = with pkgs; [
    # Browsers and Communication
    firefox
    thunderbird
    inputs.zen-browser.packages.${system}.default
    lagrange

    # Media and Entertainment
    vlc
    mpv
    plexamp
    spotify

    # Productivity and Office
    bitwarden
    obsidian
    libreoffice-still

    # Terminal Emulators
    alacritty
    kitty

    # Desktop Utilities
    wofi
  ];
}

