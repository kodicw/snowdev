{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "mainframe-nixnode";
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
      smart = enabled;
      root = enabled;
    };
    system = {
      boot.linode = enabled;
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    bundles = {
      development = enabled;
      common = enabled;
    };
    services = {
      openssh = enabled;
      cron = enabled;
      tailscale = enabled;
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
