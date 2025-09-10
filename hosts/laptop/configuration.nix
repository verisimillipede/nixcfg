# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/disko-config.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  boot.zfs.package = pkgs.zfs_2_3;
  # boot.kernelModules = [ "v4l2loopback" ];
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostId = "8425e349";
  networking.hostName = "laptop";

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.kernelModules = ["v4l2loopback"];

  services.ntopng = {
    enable = true;
    httpPort = 9094;
    extraConfig = ''
      --disable-login
      --http-prefix=/ntopng
    '';
  };

  users.users.ntopng = {
    isSystemUser = true;
    group = "ntopng";
    home = "/var/lib/ntopng";
  };

  users.groups.ntopng = {};

  systemd.tmpfiles.rules = [
    "d /var/lib/ntopng 0700 ntopng ntopng -"
  ];

  # Services
  services = {
    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };

    postgresql = {
      enable = true;
      ensureDatabases = ["mydatabase"];
      ensureUsers = [
        {
          name = "mike";
          ensureClauses = {
            superuser = true;
            createrole = true;
            createdb = true;
          };
        }
      ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        host    all       all   127.0.0.1/32   trust
        host    all       all   ::1/128        trust
      '';
    };
  };

  services.keyd = {
    enable = true;
    # Swap capslock with ctrl + esc
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
        esc = "capslock";
      };
    };
  };
  # Pulseaudio
  services.pulseaudio.enable = false;

  services.emacs.enable = true;

  services.tailscale.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.steam.enable = true;

  # programs.hyprland = {
  #   enable = true;
  #   withUWSM = true; # recommended for most users
  #   xwayland.enable = true; # Xwayland can be disabled.
  # };

  home-manager.backupFileExtension = "backup";
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
