{
  description = "A very basic flake";
  inputs = {
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "unstable";

    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nix-software-center.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";

    # nixpkgs-fixes.url = "github:NixOS/nixpkgs/91a7822b04fe5e15f1604f9ca0fb81eff61b4143";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
    sops-nix.url = "github:Mic92/sops-nix";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixos-cosmic.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          meta = {
            name = "Genix";
            title = "Normal Setup";
          };
          namespace = "genix";
        };
      };
    in

    lib.mkFlake {
      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        disko.nixosModules.disko
        nixos-cosmic.nixosModules.default
      ];
      channels-config.allowUnfree = true;
      channels-config.allowUnsupportedSystem = true;
      channels-config.nvidia.acceptLicense = true;
      channels-config.permittedInsecurePackages = [ "qtwebkit-5.212.0-alpha4" ];
      deploy = with inputs;
        {

          sshUser = "root";
          remoteBuild = false;
          autoRollback = true;
          magicRollback = true;
          nodes =
            {
              node-nadia = {
                hostname = "node-nadia";
                profiles.system = {
                  user = "root";
                  path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.node-nadia;
                };
              };
              nix-cluster = {
                hostname = "nix-cluster";
                profiles.system = {
                  user = "root";
                  path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nix-cluster;
                };
              };
              nginx-nixnode = {
                hostname = "nginx-nixnode";
                profiles.system = {
                  user = "root";
                  path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nginx-nixnode;
                };
              };
              # spectre = {
              #   hostname = "spectre";
              #   profiles.system = {
              #     user = "root";
              #     path = deploy-rs.lib.i686-linux.activate.nixos self.nixosConfigurations.spectre;
              #   };
              # };
              rpi4 = {
                hostname = "rpi4";
                profiles.system = {
                  user = "root";
                  path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.rpi4;
                };
              };
            };
        };
    };
}


