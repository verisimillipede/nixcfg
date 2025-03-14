# Common configuration for all hosts
{
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./users
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs outputs;};
  };

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
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    vim
    git
  ];

  fonts.packages = with pkgs; [
    fira
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.command-not-found.enable = false;

  services.syncthing = {
    enable = true;
    user = "mike";
    dataDir = "/home/mike";
    configDir = "/home/mike/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "server" = {
          id = "TSIUADB-CQWWY02-S7TDVKC-EKTAH5H-FLHQYIH-45RBVGD-3N7NXEC-HKNTJA2";
          addresses = ["tcp://server.turkey-mimosa.ts.net"];
        };
        "computer" = {
          id = "4CA5ZBX-FXTG3LD-PHCCFMT-MGTQO4A-LN7PNRJ-ETT7UWF-EWQLPOO-HYWYBQT";
          addresses = ["tcp://computer.turkey-mimosa.ts.net"];
        };
        "laptop" = {
          id = "3BWQ73Y-4CVISWV-XJ7QKTG-WOEMDYT-NP2353D-VZTPI2J-CPHFMMU-74ED4QI";
          addresses = ["tcp://laptop.turkey-mimosa.ts.net"];
        };
      };
      folders = {
        "Documents" = {
          path = "/home/mike/Documents";
          devices = ["server" "computer" "laptop"];
        };
        "Downloads" = {
          path = "/home/mike/Downloads";
          devices = ["server" "computer" "laptop"];
        };
        "Pictures" = {
          path = "/home/mike/Pictures";
          devices = ["server" "computer" "laptop"];
        };
        "Library" = {
          path = "/home/mike/Library";
          devices = ["server" "computer" "laptop"];
        };
        "default" = {
          path = "/home/mike/Sync";
          devices = ["server" "computer" "laptop"];
        };
        "undodir" = {
          path = "/home/mike/.vim/undodir";
          devices = ["server" "computer" "laptop"];
        };
      };
      options = {
        globalAnnounceEnabled = true;
        localAnnounceEnabled = true;
        localAnnouncePort = 21027;
        relaysEnabled = true;
        natEnabled = true;
        urAccepted = 3;
        urSeen = 3;
        urUniqueID = "GLsFQaxC";
        crashReportingEnabled = true;
        setLowPriority = true;
      };
      gui = {
        enabled = true;
        address = "127.0.0.1:8384";
        user = "mike";
        password = "$2y$10$8ZlCK0LtEAkeHVm3LxcAweLOJ9h2.B9HvULsPTqIC5YUkEwMuYwSq";
        apiKey = "ac7rxJRAiFTDY9HqpGevAgSH4SGMDP9u";
      };
    };
  };

  # Printing
  services.printing = {
    enable = true;
    drivers = [pkgs.brlaser];
  };

  # # Avahi
  # avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  # };
  # services.printing = {
  #   enable = true;
  #   listenAddresses = ["127.0.0.1:631"];
  #   allowFrom = ["all"];
  #   browsing = true;
  #   defaultShared = true;
  #   openFirewall = true;
  # };
  systemd.services.NetworkManager-wait-online.enable = false;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "mike"
      ]; # Set users that are allowed to use the flake command
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
    registry =
      (lib.mapAttrs (_: flake: {inherit flake;}))
      ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  };
}
