{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.dunst;
in
{
  options.${namespace}.cli-apps.dunst = with types;
    {
      enable = mkEnableOption "Whether or not to enable dunst.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ dunst ]; };
}
