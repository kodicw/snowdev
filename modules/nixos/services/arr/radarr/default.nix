{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.radarr;
in
{
  options.${namespace}.services.arr.radarr = with types;
    {
      enable = mkEnableOption "Whether or not to configure radarr";
    };
  config = mkIf cfg.enable {
    services.radarr = {
      enable = true;
      user = "arr";
      group = "arr";
      openFirewall = true;
    };
  };
}
