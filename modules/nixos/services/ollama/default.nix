{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.ollama;
  in
  {
  options.${namespace}.services.ollama = with types;
  {
  enable = mkEnableOption "Whether or not to configure ollama";
  };

  config = mkIf cfg.enable {
    services.ollama.enable = true;
  };
  }