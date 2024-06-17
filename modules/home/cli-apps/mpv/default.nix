{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.mpv;
  in
  {
  options.${namespace}.cli-apps.mpv = with types;
  {
  enable = mkEnableOption "Whether or not to enable mpv.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ mpv ]; };
  }