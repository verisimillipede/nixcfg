{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.mike = {
    isNormalUser = true;
    description = "mike";
    extraGroups = [
      "wheel"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.mike =
    import ../../../home/mike/${config.networking.hostName}.nix;
}

