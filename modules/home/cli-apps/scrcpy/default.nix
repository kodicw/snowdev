{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.scrcpy;
in
{
  options.${namespace}.cli-apps.scrcpy = with types;
    {
      enable = mkEnableOption "Whether or not to enable scrcpy.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ scrcpy ]; };
}
