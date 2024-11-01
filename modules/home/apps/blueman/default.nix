{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.blueman;
in
{
  options.${namespace}.apps.blueman = with types;
    {
      enable = mkEnableOption "Whether or not to enable blueman.";
    };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ blueman ]; };
}
