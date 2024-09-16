{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "nadia-jellyfin";
in
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
  ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
  genix = {
    techstack = {
      server = enabled;
    };
    user = {
      charles = enabled;
      root = enabled;
    };
    system = {
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
      stylix = enabled;
      shareclient = {
        enable = true;
        device = "100.87.112.12:/share";
      };
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      nvidia = enabled;
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      usb-automount = enabled;
      jellyfin = enabled;
    };
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  system.stateVersion = "24.05";
}
