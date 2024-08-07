{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.jellyseerr;
in
{
  options.${namespace}.services.jellyseerr = with types;
    {
      enable = mkEnableOption "Whether or not to configure jellyseerr";
    };

  config = mkIf cfg.enable {
    services.jellyseerr = {
      enable = true;
      openFirewall = true;
    };
  };
}
