# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ../common/disko-config.nix
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostId = "9de159a6";
  networking.hostName = "computer";

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Services
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = ["mydatabase"];
      ensureUsers = {
        name = "mike";
      };
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };

    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };

    # Keyd
    keyd = {
      enable = true;
      # Swap capslock with ctrl + esc
      keyboards.default.settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };

    # Tailscale
    tailscale.enable = true;

    # Pipewire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # Pulseaudio
    pulseaudio.enable = false;

    # Xserver
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
