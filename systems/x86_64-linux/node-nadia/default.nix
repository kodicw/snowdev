{ lib
, pkgs
, namespace
, ...
}:
let
  hostname = "node-nadia";
in
{
  imports = [
    ./hardware.nix
  ];
  genix = with lib.${namespace}; {
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
    desktop.bigscreen = enabled;
    bundles = {
      networking = enabled;
      gaming = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      # nvidia = {
      #   version = "legacy_470";
      #   enable = true;
      # };
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
    };
  };
  # Disable the lid switch for laptops
  # useful for when you have a laptop and you want to close the lid without the system suspending
  environment.systemPackages = with pkgs; [ genix.zen-browser jellyfin-media-player ];
  # services.logind.lidSwitch = "ignore";
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "23.05";
}
