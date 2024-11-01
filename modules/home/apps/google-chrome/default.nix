{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.google-chrome;
in
{
  options.${namespace}.apps.google-chrome = with types;
    {
      enable = mkEnableOption "Whether or not to enable google-chrome.";
    };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ google-chrome ]; };
}
