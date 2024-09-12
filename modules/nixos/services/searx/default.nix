{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.searx;
in
{
  options.${namespace}.services.searx = with types;
    {
      enable = mkEnableOption "Whether or not to configure searx";
    };

  config = mkIf cfg.enable {
    services.searx = {
      enable = true;
      package = pkgs.searxng;
    };
  };
}
