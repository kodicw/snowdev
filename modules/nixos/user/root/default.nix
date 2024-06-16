{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.user.root;
in
with lib;
{
  options = {
    ${namespace}.user.root = {
      enable = mkEnableOption "Enable root";
      sshKeys = mkOption {
        type = types.listOf types.str;
        default = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEDbKoprxQnwISBW5IbabX4rEBXKprqgfO4BQUOEpt5BrdK3/y6777Mr0lopPBQTp5S/pd5BEWcSv3XGb3llcTQRjJpH6/SHzlATVn0fwCT7wXu7P5S82zGizxAeilVoS8aTa4/38CvKikcKDtvZErNyanHlGvkohf4kOV8QcOORy8t4BdH6epbVtTZKqCe9T0tafdP+upLbnWGiu4EzHkYYu+uMRuWYrBS+kimMpuQkULsjUOhv1rsQ9kEtbsAanM+ZPMizqsHE2S0d8VyZkeNysVBTGVSCUx45zif+kdVUCH5X3n6DY7QDiPn+aAOMVP9ZaubNzM3lv+I9+JB7n+W6NGQ2ONBbTFaBR6MihpIgPVaVvUxq/Edy+iAd0tk51esCxd52LUZn/UaIBjDR2XlIobgT1yngzaJ+8CAB1xaTeXRGEBivh8yNnsRlJTg0U+4e51jo8s+0WrmG3fgZIC9NJO07Zg3ztxJPz+x306oOWpQb8XStWnMhBL+BoS2X0= charles@r2"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcgbJ626wZZs5aE9kbIc97LhDz9yeb/MmRPnYybpwJK root@mainframe"
        ];
        description = "List of SSH keys to add to the root user";
      };
    };
  };
  config = mkIf cfg.enable {
    users.users.root.openssh.authorizedKeys.keys = cfg.sshKeys;
  };
}

