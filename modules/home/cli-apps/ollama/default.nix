{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.ollama;
  in
  {
  options.${namespace}.cli-apps.ollama = with types;
  {
  enable = mkEnableOption "Whether or not to enable ollama.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ ollama ]; };
  }