{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.grimblist;
  in
  {
  options.${namespace}.cli-apps.grimblist = with types;
  {
  enable = mkEnableOption "Whether or not to enable grimblist.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ grimblist ]; };
  }