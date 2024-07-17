{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.netdata;
  in
  {
  options.${namespace}.services.netdata = with types;
  {
  enable = mkEnableOption "Whether or not to configure netdata";
  };

  config = mkIf cfg.enable {
    services.netdata.enable = true;
  };
  }