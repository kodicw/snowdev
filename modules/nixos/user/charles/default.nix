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
  cfg = config.${namespace}.user.charles;
in
with lib;
{
  options = {
    ${namespace}.user.charles.enable = mkEnableOption "Enable user charles";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        charles = {
          isNormalUser = true;
          useDefaultShell = true;
          initialPassword = "password";
          description = "charles";
          extraGroups = groups;
          packages = with pkgs; [
            starship
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiDe2CMnDgWjXqMpQHxCSOmrjuAWwZazYPORZXlr2SF u0_a518@localhost"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv8kP8LWCSGweBHEl/AmxKMLat2Y2RWonKqDSO6RrWb charles@mainframe"
          ];
        };
      };
    };
  };
}

