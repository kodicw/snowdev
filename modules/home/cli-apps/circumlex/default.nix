{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.circumflex;
in
{
  options.${namespace}.cli-apps.circumflex = with types;
    {
      enable = mkEnableOption "Whether or not to enable circumflex.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ circumflex ]; };
}
