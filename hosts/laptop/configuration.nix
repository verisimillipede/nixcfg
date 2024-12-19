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
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.zfs = {
    package = pkgs.zfs_unstable;
  };

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostId = "8425e349";
  networking.hostName = "laptop";

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # i2c for https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver
  hardware.i2c.enable = true;
  systemd.services.asus-touchpad-numpad = {
    description = "Activate Numpad inside the touchpad with top right corner switch";
    documentation = ["https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver"];
    path = [pkgs.i2c-tools];
    script = ''
      cd ${pkgs.fetchFromGitHub {
        owner = "mohamed-badaoui";
        repo = "asus-touchpad-numpad-driver";
        # These needs to be updated from time to time
        rev = "bfbd282025e1aeb2c805a881e01089fe55442e7f";
        sha256 = "sha256-NkJ2xF4111fXDUPGRUvIVXyyFmJOrlSq0u6jJUJFYes=";
      }}
      # In the last argument here you choose your layout.
      ${pkgs.python3.withPackages (ps: [ps.libevdev])}/bin/python asus_touchpad.py m433ia
    '';
    # Probably needed because it fails on boot seemingly because the driver
    # is not ready yet. Alternativly, you can use `sleep 3` or similar in the
    # `script`.
    serviceConfig = {
      RestartSec = "1s";
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
  };

  # Pulseaudio
  hardware.pulseaudio.enable = false;

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

  services.tailscale.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
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
