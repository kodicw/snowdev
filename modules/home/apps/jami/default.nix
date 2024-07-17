{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.jami;
in
{
  options.${namespace}.apps.jami = with types;
    {
      enable = mkEnableOption "Whether or not to enable jami.";
    };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ jami-client ]; };
}
