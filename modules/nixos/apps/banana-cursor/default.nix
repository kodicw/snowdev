{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.banana-cursor;
in
{
  options.${namespace}.apps.banana-cursor = with types;
    {
      enable = mkEnableOption "Whether or not to enable banana-cursor.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ banana-cursor ]; };
}
