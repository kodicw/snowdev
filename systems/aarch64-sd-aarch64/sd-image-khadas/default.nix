{ config
, inputs
, pkgs
, namespace
, modulesPath
, lib
, ...
}:
with lib;
with lib.${namespace};
{
  imports = with inputs.nixos-hardware.nixosModules; [
    # (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    # ./hardware.nix
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
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
      stylix = enabled;
      share = enabled;
    };
    cli-apps = {
      netdiscover = enabled;
    };
    bundles = {
      development = enabled;
      arr = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      cron = enabled;
      jellyseerr = enabled;
      tailscale = {
        enable = true;
        upFlags = [ "--exit-node=146.70.211.70" ];
      };
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
  networking.hostName = "sd-image-khadas";
  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}