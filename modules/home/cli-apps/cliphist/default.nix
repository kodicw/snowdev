{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.cliphist;
  in
  {
  options.${namespace}.cli-apps.cliphist = with types;
  {
  enable = mkEnableOption "Whether or not to enable cliphist.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ cliphist ]; };
  }