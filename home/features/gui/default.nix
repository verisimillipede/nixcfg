{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Browsers and Communication
    firefox
    thunderbird
    inputs.zen-browser.packages.${system}.default

    lagrange

    gnome-extension-manager
    gnomeExtensions.pano
    gnomeExtensions.clipboard-history
    gnome-tweaks

    # Media and Entertainment
    darktable
    ansel
    shotwell
    digikam
    vlc
    mpv
    plexamp
    spotify
    readarr
    calibre

    # Productivity and Office
    bitwarden
    obsidian
    libreoffice-still
    maestral
    maestral-gui

    # Terminal Emulators
    alacritty
    kitty
    ghostty

    # Desktop Utilities
    wofi
  ];
}
