{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "mainframe";
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
      angel = enabled;
      phoenix = enabled;
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
      hyprland = enabled;
    };
    bundles = {
      arr = enabled;
      gaming = enabled;
      development = enabled;
      hyprland = enabled;
      networking = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      nvidia = enabled;
      networkmanager = enabled;
    };
    services = {
      openrgb = enabled;
      openssh = enabled;
      cron = enabled;
      tailscale = enabled;
      mongodb = enabled;
      usb-automount = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
    apps = {
      firefox = enabled;
      kdeconnect = enabled;
    };
    cli-apps = {
      rgbctl = enabled;
      neovide = enabled;
    };
  };

  environment.systemPackages = with pkgs; [ chromedriver ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  services.xserver = {
    xrandrHeads = [
      {
        output = "DP-0";
        primary = true;
      }
      {
        output = "HDMI-0";
        monitorConfig = ''Option "Enable" "false"'';
      }
    ];
  };
  system.stateVersion = "24.05";
}
