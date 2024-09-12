{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "hp-server";
in
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
      boot.grub = enabled;
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
      stylix = enabled;
    };
    bundles = {
      development = enabled;
      networking = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networkmanager = enabled;
    };
    services = {
      openrgb = enabled;
      openssh = enabled;
      cron = enabled;
      tailscale = enabled;
      usb-automount = enabled;
      # tt-rss = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };

  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "24.05";
}
