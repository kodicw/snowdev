{ lib
, pkgs
, modulesPath
, namespace
, config
, ...
}:
let
  hostname = "nixnode";
in
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
  ];
  genix = {
    techstack = {
      server = enabled;
    };
    user = {
      charles = enabled;
      root = enabled;
    };
    system = {
      boot.linode = enabled;
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      nextcloud = {
        enable = true;
        hostName = "nextcloud.declarativepenguin.com";
        email = "kodicw@gmail.com";
      };
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };

  networking = {
    hostName = hostname;
  };

  system.stateVersion = "24.05";
}
