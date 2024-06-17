{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.piper-tts;
  in
  {
  options.${namespace}.cli-apps.piper-tts = with types;
  {
  enable = mkEnableOption "Whether or not to enable piper-tts.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ piper-tts ]; };
  }