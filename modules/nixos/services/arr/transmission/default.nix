{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.transmission;
in
{
  options.${namespace}.services.arr.transmission = with types;
    {
      enable = mkEnableOption "Whether or not to configure transmission";
    };

  config = mkIf cfg.enable {
    services.transmission.enable = true;
  };
}
