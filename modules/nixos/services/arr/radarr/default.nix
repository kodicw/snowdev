{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.radarr;
in
{
  options.${namespace}.services.arr.radarr = with types;
    {
      enable = mkEnableOption "Whether or not to configure radarr";
      dataDir = mkOption {
        type = types.str;
        default = "/var/lib/radarr";
        description = "The directory where radarr will store its data";
      };

    };
  config = mkIf cfg.enable {
    services.radarr = {
      enable = true;
      user = "arr";
      group = "arr";
      openFirewall = true;
    };
  };
}
