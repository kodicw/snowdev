{ lib
, pkgs
, modulesPath
, namespace
, ...
}:
let
  hostname = "mainframe";
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
      plasma = enabled;
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
      firefox = enabled;
      kdeconnect = enabled;
      bruno = enabled;
    };
    cli-apps = {
      rgbctl = enabled;
      neovide = enabled;
      adb = enabled;
    };
    # containers.librenms = { enable = true;};
  };


  environment.systemPackages = with pkgs; [ chromedriver ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
