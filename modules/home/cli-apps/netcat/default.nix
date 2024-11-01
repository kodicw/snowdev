{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.netcat;
in
{
  options.${namespace}.cli-apps.netcat = with types;
    {
      enable = mkEnableOption "Whether or not to enable netcat.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ netcat ]; };
}
