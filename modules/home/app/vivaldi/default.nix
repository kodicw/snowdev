{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.vivaldi;
  in
  {
  options.${namespace}.apps.vivaldi = with types;
  {
  enable = mkEnableOption "Whether or not to enable vivaldi.";
  };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ vivaldi ]; };
  }