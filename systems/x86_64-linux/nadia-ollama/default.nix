{ lib
, namespace
, ...
}:
let
  hostname = "nadia-ollama";
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
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      ollama = enabled;
    };
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  system.stateVersion = "24.05";
}
