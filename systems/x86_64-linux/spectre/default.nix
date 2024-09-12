{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "spectre";
in
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
  ];
  genix = {
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
    ai = {
      ollama = enabled;
    };
    desktop = {
      cosmic = enabled;
    };
    bundles = {
      development = enabled;
      common = enabled;
      desktop = enabled;
      networking = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      cron = enabled;
      tailscale = enabled;
      usb-automount = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
    apps = {
      kdeconnect = enabled;
      bruno = enabled;
    };
    cli-apps = {
      adb = enabled;
    };
  };
  environment.systemPackages = with pkgs; [ chromedriver genix.zen-browser ];
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "23.11";
}
