{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.circumlex;
  in
  {
  options.${namespace}.cli-apps.circumlex = with types;
  {
  enable = mkEnableOption "Whether or not to enable circumlex.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ circumlex ]; };
  }