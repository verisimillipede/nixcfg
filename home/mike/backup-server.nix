{...}: {
  imports = [
    ./home.nix
    ../features/servers
    ../common
  ];

  features.cli = {
    fish.enable = true;
    tmux.enable = true;
  };
}
