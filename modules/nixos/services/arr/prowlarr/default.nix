{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.prowlarr;
in
{
  options.${namespace}.services.arr.prowlarr = with types;
    {
      enable = mkEnableOption "Whether or not to configure prowlarr";
    };

  config = mkIf cfg.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
    };
  }
