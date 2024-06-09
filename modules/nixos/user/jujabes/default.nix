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
  cfg = config.${namespace}.user.jujabes;
in
with lib;
{
  options = {
    ${namespace}.user.jujabes.enable = mkEnableOption "Enable user jujabes";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        jujabes = {
          isNormalUser = true;
          useDefaultShell = true;
          initialPassword = "password";
          description = "jujabes";
          extraGroups = groups;
        };
      };
    };
  };
}

