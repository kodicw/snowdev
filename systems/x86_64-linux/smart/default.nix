# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, genix, ... }:

{
  imports =
    [ 
      ./hardware.nix
    ];
  genix = {
    techstack = {
      work.enable = true;
    };
   system = {
      locale.enable = true;
      fonts.enable = true;
      time.enable = true;
      xkb.enable = true;
    };
    desktop = {
      hyprland.enable = true;
      plasma.enable = true;
    };
    bundles = {
      hyprland.enable = true;
      networking.enable = true;
    };
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      networkmanager.enable = true;
    };
    services = {
      openrgb.enable = true;
      openssh.enable = true;
      cron.enable = true;
      usb-automount.enable = true;
    };
    virtualisation = {
      docker.enable = true;
      virt-manager.enable = true;
      vmVariant.enable = true;
    };
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "smart"; # Define your hostname.
  services.printing.enable = true;
  services.logind.lidSwitch = "suspend";
  services.logind.powerKey = "hybrid-sleep";
  networking.networkmanager.wifi.powersave = true;
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  programs.nix-ld.enable = true;
  users.users.kodiw = {
    isNormalUser = true;
    description = "Kodi Walls";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.openssh.enable = true;
}
