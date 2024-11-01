{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.brightnessctl;
in
{
  options.${namespace}.cli-apps.brightnessctl = with types;
    {
      enable = mkEnableOption "Whether or not to enable brightnessctl.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ brightnessctl ]; };
}
