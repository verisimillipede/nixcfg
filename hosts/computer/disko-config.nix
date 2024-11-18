{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
                # Consider adding compression options here
                compression = "zstd";
              };
            };
          };
        };
      };
    };
  };
  zpool = {
    zroot = {
      type = "zpool";
      mountpoint = "/";
      # Consider adding pool-wide options here
      options = {
        ashift = "12";
        autotrim = "on";
      };
      datasets = {
        root = {
          type = "zfs_fs";
          mountpoint = "/";
        };
        home = {
          type = "zfs_fs";
          mountpoint = "/home";
        };
        # Consider adding more datasets if needed
        # nix = {
        #   type = "zfs_fs";
        #   mountpoint = "/nix";
        # };
      };
    };
  };
}
