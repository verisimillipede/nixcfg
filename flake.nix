{
  description = ''
    For questions just DM me on X: https://twitter.com/@m3tam3re
    There is also some NIXOS content on my YT channel: https://www.youtube.com/@m3tam3re

    One of the best ways to learn NIXOS is to read other peoples configurations. I have personally learned a lot from Gabriel Fontes configs:
    https://github.com/Misterio77/nix-starter-configs
    https://github.com/Misterio77/nix-config

    Please also check out the starter configs mentioned above.
  '';

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Zen Browser
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    zen-browser,
    home-manager,
    disko,
    colmena,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages =
      forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays {inherit inputs;};
    nixosConfigurations = {
      computer = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/computer
          inputs.disko.nixosModules.disko
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/laptop
          inputs.disko.nixosModules.disko
        ];
      };
      vintagepc = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/vintagepc
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/server
          inputs.disko.nixosModules.disko
        ];
      };
    };
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        specialArgs = {inherit inputs outputs;};
      };

      computer = {
        deployment = {
          targetHost = "computer";
          targetUser = "mike";
          allowLocalDeployment = true;
          tags = ["computer"];
          # buildOnTarget = true;
        };
        imports = [
          ./hosts/computer
          inputs.disko.nixosModules.disko
        ];
      };

      laptop = {
        deployment = {
          targetHost = "laptop";
          targetUser = "mike";
          allowLocalDeployment = true;
          tags = ["laptop"];
          # buildOnTarget = true;
        };
        imports = [
          ./hosts/laptop
          inputs.disko.nixosModules.disko
        ];
      };

      server = {
        deployment = {
          targetHost = "server";
          targetUser = "mike";
          buildOnTarget = true;
          tags = ["server"];
        };
        imports = [
          ./hosts/server
          inputs.disko.nixosModules.disko
        ];
      };
    };

    homeConfigurations = {
      "mike@computer" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit self inputs outputs;};
        modules = [./home/mike/computer.nix];
      };
      "mike@laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit self inputs outputs;};
        modules = [./home/mike/laptop.nix];
      };
      "mike@vintagepc" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit self inputs outputs;};
        modules = [./home/mike/vintagepc.nix];
      };
      "mike@server" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit self inputs outputs;};
        modules = [./home/mike/server.nix];
      };
    };
  };
}
