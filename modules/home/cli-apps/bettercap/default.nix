{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.bettercap;
in
{
  options.${namespace}.cli-apps.bettercap = with types;
    {
      enable = mkEnableOption "Whether or not to enable bettercap.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ bettercap ]; };
}
