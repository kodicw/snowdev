{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.pamixer;
  in
  {
  options.${namespace}.cli-apps.pamixer = with types;
  {
  enable = mkEnableOption "Whether or not to enable pamixer.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ pamixer ]; };
  }