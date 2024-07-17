{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
with lib;
with lib.${namespace};
{
  genix = {
    user = {
      charles = enabled;
      root = enabled;
    };
    system = {
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    bundles = {
      common = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = {
        enable = true;
        tempAuthKey = true;
      };
    };
  };
  networking = {
    hostName = "linode-server";
    networkmanager.enable = true;
  };
}
