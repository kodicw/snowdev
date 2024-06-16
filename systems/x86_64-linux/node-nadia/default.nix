{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
  ];
  genix = {
    techstack = {
      server = enabled;
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
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      adguardHome = enabled;
      homepage = enabled;
      soft-serve = enabled;
      photoprism = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };
  networking = {
    hostName = "node-nadia";
    networkmanager.enable = true;
    interfaces.wlp5s0.ipv4.addresses = [{
      address = "192.168.1.12";
      prefixLength = 24;
    }];
  };
}
