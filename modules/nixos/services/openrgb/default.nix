{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.openrgb;
in
{
  options.${namespace}.services.openrgb = with types;
    {
      enable = mkEnableOption "Whether or not to configure openrgb";
    };

  config = mkIf cfg.enable {
    services.hardware.openrgb.enable = true;
  };
}
