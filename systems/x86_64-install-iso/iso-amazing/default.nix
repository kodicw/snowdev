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
    stylix = enabled;
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
      tailscale = enabled;
    };
    tools = {
      iso-net-info = enabled;
    };
  };
  networking = {
    hostName = "iso-amazing";
    networkmanager.enable = true;
  };
}
