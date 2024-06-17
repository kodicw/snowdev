{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "node-nadia";
in
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
  ];
  genix = {
    techstack = {
      workstation = enabled;
    };
    user = {
      charles = enabled;
      root = enabled;
    };
    system = {
      boot.grub.enable = true;
      boot.grub.device = "/dev/sda";
      boot.grub.efiSupport = false;
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      nvidia = enabled;
    };
    desktop = {
      plasma = enabled;
      hyprland = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      adguardHome = enabled;
      homepage = enabled;
      soft-serve = enabled;
      photoprism = enabled;
      ollama = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    interfaces.wlp5s0.ipv4.addresses = [{
      address = "192.168.1.12";
      prefixLength = 24;
    }];
  };
  system.stateVersion = "23.05";
}
