{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.iw;
in
{
  options.${namespace}.cli-apps.iw = with types;
    {
      enable = mkEnableOption "Whether or not to enable iw.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ iw ]; };
}
