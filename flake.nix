{
  description = "A very basic flake";
  inputs = {
    unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nix-software-center.url = "github:snowfallorg/nix-software-center";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-fixes.url = "github:NixOS/nixpkgs/91a7822b04fe5e15f1604f9ca0fb81eff61b4143";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
    sops-nix.url = "github:Mic92/sops-nix";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
        disko.nixosModules.disko
      ];
      channels-config.allowUnfree = true;
      channels-config.permittedInsecurePackages = [ "qtwebkit-5.212.0-alpha4" ];
      deploy = with inputs;
        {

          sshUser = "root";
          remoteBuild = false;
          nodes = {
            node-nadia = {
              hostname = "node-nadia";
              profiles.system = {
                user = "root";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.node-nadia;
              };
            };
            nixnode = {
              hostname = "nixnode";
              profiles.system = {
                user = "root";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixnode;
              };
            };
            zabbix-nixnode = {
              hostname = "zabbix-nixnode";
              profiles.system = {
                user = "root";
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.zabbix-nixnode;
              };
            };
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


