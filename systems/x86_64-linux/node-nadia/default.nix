{ lib
, pkgs
, modulesPath
, namespace
, inputs
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
  systemd.services.NetworkManager-wait-online.enable = false;
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
    desktop.hyprland = enabled;
    bundles = {
      development = enabled;
      hyprland = enabled;
      common = enabled;
      desktop = enabled;
      networking = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      nvidia = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
      ollama = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };
  # Disable the lid switch for laptops
  # useful for when you have a laptop and you want to close the lid without the system suspending
  environment.systemPackages = with pkgs; [ genix.zen-browser ];
  services.logind.lidSwitch = "ignore";

  networking = {
    hostName = hostname;
    interfaces = {
      enp4s0.ipv4.addresses = [{
        address = "192.168.1.121";
        prefixLength = 24;
      }];
      wlp5s0.ipv4.addresses = [{
        address = "192.168.1.121";
        prefixLength = 24;
      }];
    };
  };
  system.stateVersion = "23.05";
}
