# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/disko-config.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  # boot.zfs = {
  #   package = pkgs.zfs_unstable;
  # };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostId = "007f0101";
  networking.hostName = "server";

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  virtualisation.docker.enable = true;
  # Services
  services.zfs = {
    autoScrub.enable = true;
    autoSnapshot.enable = true;
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

  services.tailscale.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  services.postgresql = {
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
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE  DBUSER  ADDRESS       AUTH-METHOD
        local all       all                   trust
        host  all       all     127.0.0.1/32  trust
        host  all       all     ::1/128       trust
        host  all       all     100.64.0.0/10 trust
    '';
  };
  programs.ssh.startAgent = true;

  # services.xserver = {
  #   enable = true;
  #   displayManager.gdm.enable = true;
  #   desktopManager.gnome.enable = true;
  #   xkb = {
  #     layout = "us";
  #     variant = "";
  #   };
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
