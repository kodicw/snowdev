{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.netbox;
  in
  {
  options.${namespace}.services.netbox = with types;
  {
  enable = mkEnableOption "Whether or not to configure netbox";
  };

  config = mkIf cfg.enable {
    services.netbox.enable = true;
  };
  }