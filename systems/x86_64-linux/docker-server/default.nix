{ lib
, pkgs
, modulesPath
, namespace
, config
, ...
}:
let
  hostname = "docker-server";
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
    virtualisation = {
      docker = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = {
        enable = true;
        tempAuthKey = true;
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 80 ];
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "24.05";
}
