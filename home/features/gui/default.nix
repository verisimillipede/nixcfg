{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Browsers and Communication
    firefox
    thunderbird
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    djlint
    obs-studio
    tetex
    vale
    zotero
    zoom-us
    orca-slicer
    bambu-studio
    sioyek
    logseq
    gnome-extension-manager
    gnomeExtensions.pano
    gnomeExtensions.clipboard-history
    gnome-tweaks

    # Media and Entertainment
    vlc
    mpv
    plexamp
    spotify
    readarr
    calibre

    # Productivity and Office
    bitwarden-desktop
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
