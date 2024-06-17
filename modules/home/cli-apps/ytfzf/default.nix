{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.ytfzf;
  in
  {
  options.${namespace}.cli-apps.ytfzf = with types;
  {
  enable = mkEnableOption "Whether or not to enable ytfzf.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ ytfzf ]; };
  }