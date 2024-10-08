{ lib
, namespace
, ...
}:
let
  hostname = "exit-nixnode";
in
{
  imports = [
    ./hardware.nix
  ];
  genix = with lib.${namespace}; {
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
      tailscale = {
        enable = true;
        upFlags = [ "--advertise-exit-node" ];
        tempAuthKey = true;
        useRoutingFeatures = "server";
      };
    };
  };
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "24.05";
}
