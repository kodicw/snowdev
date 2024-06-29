{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.burpsuite;
in
{
  options.${namespace}.cli-apps.burpsuite = with types;
    {
      enable = mkEnableOption "Whether or not to enable burpsuite.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ burpsuite ]; };
}
