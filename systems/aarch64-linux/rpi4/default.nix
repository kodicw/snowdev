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
    raspberry-pi-4
    ./hardware.nix
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
      time = enabled;
      xkb = enabled;
      rpi4 = enabled;
      share = {
        enable = true;
        exports = ''
          /export        192.168.1.13(rw,fsid=0,no_subtree_check) 100.68.109.59(rw,fsid=0,no_subtree_check) 
          /export/share  192.168.1.13(rw,nohide,insecure,no_subtree_check) 100.68.109.59(rw,nohide,insecure,no_subtree_check)
        '';
        device = "/mnt/wdhdd";
      };
    };
    bundles = {
      arr = enabled;
    };
    hardware = {
      audio = enabled;
      bluetooth = enabled;
      networkmanager = enabled;
    };
    services = {
      openssh = enabled;
      jellyfin = enabled;
      cron = enabled;
      jellyseerr = enabled;
      tailscale = {
        enable = true;
        upFlags = [ "--exit-node=146.70.211.70" ];
      };
    };
    virtualisation = {
      docker = enabled;
    };
  };
  networking.hostName = "rpi4";
  system.stateVersion = "23.11";
}
