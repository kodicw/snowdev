{ lib
, pkgs
, modulesPath
, namespace
, channels
, ...
}:
let
  hostname = "nadia-forgejo";
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
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      forgejo = enabled;
    };
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  networking.firewall.allowedTCPPorts = [ 3000 ];
  system.stateVersion = "24.05";
}
