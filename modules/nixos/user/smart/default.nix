{ config, pkgs, lib, namespace, ... }:
let
  groups = [
    "networkmanager"
    "wheel"
    "libvirtd"
    "docker"
    "audio"
    "dialout"
  ];
  cfg = config.${namespace}.user.smart;
in
with lib;
{
  options = {
    ${namespace}.user.smart.enable = mkEnableOption "Enable user smart";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        smart = {
          isNormalUser = true;
          useDefaultShell = true;
          initialHashedPassword = "$y$j9T$gSxRpeHmBy9Qt8Iz0gkEE0$6RYzT2krsz8HiAk.X.q3AVkMwpOL85FkayNFt.6saC4";
          description = "smart";
          extraGroups = groups;
          packages = with pkgs; [
            starship
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADAqv0BNqlFhPHbHJ2qSFNzIZ9y29EgNrv9NLYCuboF kodi.walls_smartcomm@PC-40129"
          ];
        };
      };
    };
  };
}

