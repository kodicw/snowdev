{ lib
, pkgs
, namespace
, ...
}:
let
  hostname = "spectre";
in
{
  imports = [
    ./hardware.nix
  ];

  ${namespace} = with lib.${namespace};{
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
    };
    desktop = {
      hyprland = enabled;
    };
    bundles = {
      development = enabled;
      common = enabled;
      hyprland = enabled;
      desktop = enabled;
      networking = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
    };
    services = {
      openssh = enabled;
      cron = enabled;
      tailscale = enabled;
      usb-automount = enabled;
    };
    apps = {
      kdeconnect = enabled;
      bruno = enabled;
    };
    cli-apps = {
      adb = enabled;
    };
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Place any dynamicly linked libraries here
  ];
  environment.systemPackages = with pkgs; [ chromedriver genix.zen-browser ];
  systemd.services.NetworkManager-wait-online.enable = false;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  system.stateVersion = "24.05";
}
