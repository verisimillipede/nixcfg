{...}: {
  imports = [
    ./home.nix
    ../features/cli
    ../features/gui
    ../common
  ];

  features.cli = {
    fish.enable = true;
    tmux.enable = true;
  };
}
