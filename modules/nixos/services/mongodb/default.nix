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
  };

  config = mkIf cfg.enable {
    services.mongodb.enable = true;
  };
  }