{ lib
, namespace
, ...
}:
let
  hostname = "angel";
in
{
  imports = [
    ./hardware.nix
  ];
  genix = with lib.${namespace}; {
    techstack = {
      workstation = enabled;
    };
    user = {
      angel = enabled;
      root = enabled;
    };
    system = {
      boot.grub = enabled;
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    desktop = {
      hyprland = enabled;
    };
    bundles = {
      gaming = enabled;
      development = enabled;
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
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  system.stateVersion = "24.05";
}
