{
  pkgs,
  inputs,
  ...
}: {
  
  # zotero does not work with new firefox bin
  nixpkgs.config.permittedInsecurePackages = [
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
  ];

  home.packages = with pkgs; [
    # Browsers and Communication
    geogebra6
    zotero #broken right now....
    wike
    harper
    texliveFull
    rapidraw
    auctex
    # digikam
    firefox
    google-chrome
    # thunderbird
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    djlint
    obs-studio
    vale
    zoom-us
    orca-slicer
    # bambu-studio
    sioyek
    gnome-extension-manager
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
    obsidian
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
