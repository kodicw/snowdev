{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.hackrf;
  in
  {
  options.${namespace}.cli-apps.hackrf = with types;
  {
  enable = mkEnableOption "Whether or not to enable hackrf.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ hackrf ]; };
  }