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
      art = enabled;
      hyprland = enabled;
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
    apps = {
      kdeconnect = enabled;
      bruno = enabled;
    };
    cli-apps = {
      adb = enabled;
    };
  };
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = "charles";
      };
      default_session = initial_session;
    };
  };
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [ chromedriver genix.zen-browser ];
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };
  system.stateVersion = "24.05";
}
