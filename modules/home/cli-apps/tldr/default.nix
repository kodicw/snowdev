{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.tldr;
  in
  {
  options.${namespace}.cli-apps.tldr = with types;
  {
  enable = mkEnableOption "Whether or not to enable tldr.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ tldr ]; };
  }