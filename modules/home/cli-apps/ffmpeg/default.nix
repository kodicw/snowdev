{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.ffmpeg;
  in
  {
  options.${namespace}.cli-apps.ffmpeg = with types;
  {
  enable = mkEnableOption "Whether or not to enable ffmpeg.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ ffmpeg ]; };
  }