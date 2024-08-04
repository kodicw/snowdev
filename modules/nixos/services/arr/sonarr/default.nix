{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.sonarr;
in
{
  options.${namespace}.services.arr.sonarr = with types;
    {
      enable = mkEnableOption "Whether or not to configure sonarr";
      dataDir = mkOption {
        type = types.path;
        default = "/var/lib/sonarr";
        description = "The directory where sonarr will store its data";
      };

    };

  config = mkIf cfg.enable {
    services.sonarr = {
      enable = mkForce true;
      openFirewall = true;
      dataDir = cfg.dataDir;
    };
  };
}
