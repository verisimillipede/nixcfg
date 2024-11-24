{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        options = {
          ashift = "12";
        };
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "lz4";
          mountpoint = "none";
          xattr = "sa";
          "com.sun:auto-snapshot" = "true";
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
        };
      };
    };
  };
}
