{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.jellyfin;
  in
  {
  options.${namespace}.services.jellyfin = with types;
  {
  enable = mkEnableOption "Whether or not to configure jellyfin";
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
  }
