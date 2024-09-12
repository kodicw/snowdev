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
      shareclient = {
        enable = true;
        device = "100.87.112.12:/share";
      };
    };
    ai = {
      ollama = enabled;
    };
    desktop = {
      hyprland = enabled;
    };
    bundles = {
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
      searx = enabled;
      cron = enabled;
      tailscale = enabled;
      usb-automount = enabled;
      jellyfin = enabled;
      # tt-rss = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
    apps = {
      firefox = enabled;
      kdeconnect = enabled;
      bruno = enabled;
    };
    cli-apps = {
      rgbctl = enabled;
      neovide = enabled;
      adb = enabled;
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
