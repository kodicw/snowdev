{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.grimblast;
in
{
  options.${namespace}.cli-apps.grimblast = with types;
    {
      enable = mkEnableOption "Whether or not to enable grimblast.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ grimblast ]; };
}
