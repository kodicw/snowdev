{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.tt-rss;
in
{
  options.${namespace}.services.tt-rss = with types;
    {
      enable = mkEnableOption "Whether or not to configure tt-rss";
    };

  config = mkIf cfg.enable {
    services.tt-rss = {
      enable = true;
      selfUrlPath = "http://mainframe";
    };
  };
}
