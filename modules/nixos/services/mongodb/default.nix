{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.mongodb;
in
{
  options.${namespace}.services.mongodb = with types;
    {
      enable = mkEnableOption "Whether or not to configure mongodb";
      user = mkOption {
        type = types.str;
      default = "charles";
      };
    };

  config = mkIf cfg.enable {
    services.mongodb = {
      enable = true;
      user = cfg.user;
    };
  };
}
