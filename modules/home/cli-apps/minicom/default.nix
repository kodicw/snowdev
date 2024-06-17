{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.minicom;
  in
  {
  options.${namespace}.cli-apps.minicom = with types;
  {
  enable = mkEnableOption "Whether or not to enable minicom.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ minicom ]; };
  }