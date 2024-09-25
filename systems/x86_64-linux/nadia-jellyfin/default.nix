{ lib
, namespace
, ...
}:
let
  hostname = "nadia-jellyfin";
in
{
  imports = [
    ./hardware.nix
  ];
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };
  genix = with lib.${namespace}; {
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
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      jellyfin = enabled;
    };
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  system.stateVersion = "24.05";
}
