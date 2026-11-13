{
  lib,
  outputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home.sessionVariables = {
    EDITOR = "emacs";
    BROWSER = "zen-beta";
    TERMINAL = "kitty";
  };

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-termfilechooser
    ];

    config = {
      # to find XDG files : got to the {hash} of the new version and find file named xdg-desktop*
      # .services files are located : /etc/profiles/per-user/...{user}.../share/systemd/user

      # pattern :
      # {name} -> "{name}-" -> {name}-portals.conf file

      # common -> empty -> portals.conf file
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.Inhibit" = [ "none" ];

        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };

      # wlroots -> "wlroots-" -> wlroots-portals.conf file
      wlroots = {
      };
  };
    xdg.configFile = {
      "xdg-desktop-portal-termfilechooser/config" = {
        force = true;
        executable = true;
        text = ''
          [filechooser]
          cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
          default_dir=$HOME/downloads
          create_help_file=1
          env=TERMCMD='kitty --title filechooser'
          env=PATH="$PATH:/run/current-system/sw/bin"
          open_mode=suggested
          save_mode=last
        '';
      };
    };
  xdg.desktopEntries.zen = {
    name = "Zen-Beta";
    genericName = "Web Browser";
    exec = "zen-beta %U";
    terminal = false;
    categories = ["Network" "WebBrowser"];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = ["zen.desktop"];
      "text/xml" = ["zen.desktop"];
      "application/xhtml+xml" = ["zen.desktop"];
      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
      "video/mp4" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/x--msvideo" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
    };
  };
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };
}
