{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.pass;
  in
  {
  options.${namespace}.cli-apps.pass = with types;
  {
  enable = mkEnableOption "Whether or not to enable pass.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ pass ]; };
  }