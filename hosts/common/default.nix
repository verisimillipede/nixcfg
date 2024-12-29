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
            id = "BP6PSJT-HNYSW2J-XQL7MLJ-NEWAYUD-YE36UIJ-ZJFYSVD-AKJIRRV-KVZ7PAR";
            addresses = ["tcp://server.turkey-mimosa.ts.net"];
          };
          "computer" = {
            id = "CKCXMHO-GYPVZM3-7EO4YKM-Z2L6RY6-Y262EUO-Z5KYWQM-S3VGDBD-PVIETQQ";
            addresses = ["tcp://computer.turkey-mimosa.ts.net"];
          };
          "laptop" = {
            id = "QB2KDVA-FQUUNVM-O3DJDIK-BR4ZX6X-K6QJICC-F5YNQNW-NN3NDEA-M2BVIQQ";
            addresses = ["tcp://laptop.turkey-mimosa.ts.net"];
          };
        };
        folders = {
          "Documents" = {
            path = "~/Documents";
            devices = ["server" "computer" "laptop"];
          };
          "Downloads" = {
            path = "/home/mike/Downloads";
            devices = ["server" "computer" "laptop"];
          };
          "Pictures" = {
            path = "~/Pictures";
            devices = ["server" "computer" "laptop"];
          };
          "default" = {
            path = "/home/mike/Sync";
            devices = ["server" "computer" "laptop"];
          };
          "undodir" = {
            path = "~/.vim/undodir";
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
          address = "100.77.194.40:8384";
          user = "mike";
          password = "$2y$10$8ZlCK0LtEAkeHVm3LxcAweLOJ9h2.B9HvULsPTqIC5YUkEwMuYwSq";
          apiKey = "ac7rxJRAiFTDY9HqpGevAgSH4SGMDP9u";
        };
      };
    };

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
