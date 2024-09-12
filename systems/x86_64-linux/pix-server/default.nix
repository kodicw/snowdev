{ lib
, pkgs
, modulesPath
, namespace
, config
, ...
}:
let
  hostname = "pix-server";
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
      pixelfed = enabled;
      openssh = enabled;
      tailscale = {
        enable = true;
        tempAuthKey = true;
      };
    };
  };
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "24.05";
}
