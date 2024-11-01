{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.streamdeck-ui;
in
{
  options.${namespace}.apps.streamdeck-ui = with types;
    {
      enable = mkEnableOption "Whether or not to enable streamdeck-ui.";
    };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ streamdeck-ui ]; };
}
