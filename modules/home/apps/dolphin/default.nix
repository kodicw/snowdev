{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.dolphin;
in
{
  options.${namespace}.apps.dolphin = with types;
    {
      enable = mkEnableOption "Whether or not to enable dolphin.";
    };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ dolphin ]; };
}
