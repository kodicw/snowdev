{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.slurp;
  in
  {
  options.${namespace}.cli-apps.slurp = with types;
  {
  enable = mkEnableOption "Whether or not to enable slurp.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ slurp ]; };
  }