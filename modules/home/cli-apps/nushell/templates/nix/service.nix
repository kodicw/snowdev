{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.<service-name>;
  in
  {
  options.${namespace}.services.<service-name> = with types;
  {
  enable = mkEnableOption "Whether or not to configure <service-name>";
  };

  config = mkIf cfg.enable {
    services.<service-name>.enable = true;
  };
  }
