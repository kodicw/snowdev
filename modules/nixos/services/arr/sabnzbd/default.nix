{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.sabnzbd;
in
{
  options.${namespace}.services.arr.sabnzbd = with types;
    {
      enable = mkEnableOption "Whether or not to configure sabnzbd";
    };

  config = mkIf cfg.enable {
    services.sabnzbd = {
      enable = true;
      user = "arr";
      group = "arr";
      openFirewall = true;
    };
  };
}
