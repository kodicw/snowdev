{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.whois;
  in
  {
  options.${namespace}.cli-apps.whois = with types;
  {
  enable = mkEnableOption "Whether or not to enable whois.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ whois ]; };
  }