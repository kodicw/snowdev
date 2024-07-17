{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.disko.common;
in
{
  options.${namespace}.system.disko.common = with types;
    {
      enable = mkEnableOption "Whether or not to enable";
      sda = mkEnableOption "Whether or not to enable /dev/sda";
    };

  config =
    mkIf cfg.enable {
      disko.devices.disk = {
        sda = mkIf cfg.sda {
          device = "/dev/sda";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                type = "EF00";
                size = "500M";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
}
