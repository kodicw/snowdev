{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.ai.ollama;
in
{
  options.${namespace}.ai.ollama = {
    enable = mkEnableOption "Whether or not to enable ollama.";
  };

  config = mkIf cfg.enable {
    services.ollama.enable = true;
  };
}
