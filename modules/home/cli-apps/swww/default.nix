{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.swww;
  in
  {
  options.${namespace}.cli-apps.swww = with types;
  {
  enable = mkEnableOption "Whether or not to enable swww.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ swww ]; };
  }