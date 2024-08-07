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
    desktop = {
      gnome = enabled;
    };
    system = {
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    bundles = {
      common = enabled;
      development = enabled;
    };
    services = {
      openssh = enabled;
      xrdp = enabled;
      tailscale = {
        enable = true;
        tempAuthKey = true;
      };
    };
    apps = {
      gparted = enabled;

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
