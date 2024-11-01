{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.rpi-imager;
in
{
  options.${namespace}.apps.rpi-imager = with types;
    {
      enable = mkEnableOption "Whether or not to enable rpi-imager.";
    };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ rpi-imager ]; };
}
