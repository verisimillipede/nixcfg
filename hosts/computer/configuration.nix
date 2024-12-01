# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = ["zfs"];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostId = "9de159a6"; # Define your hostId

  networking.hostName = "computer"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Pulseaudio
  hardware.pulseaudio.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mike = {
    isNormalUser = true;
    description = "mike";
    extraGroups = ["networkmanager" "wheel" "plocate"];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
    users.mike =
      import ../../home/mike/${config.networking.hostName}.nix;
  };

  # Services
  services = {
    zfs = {
      autoScrub.enable = true;
      autoSnapshot.enable = true;
    };
    sane = {
            enable = true;
            extraBackends = [ pkgs.sane-backends ];
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
    # Printing
    printing = {
      enable = true;
      drivers = [pkgs.brlaser];
    };
    # Avahi
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    # Pipewire
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
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

  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
