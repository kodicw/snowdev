{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.deluge;
in
{
  options.${namespace}.services.arr.deluge = with types;
    {
      enable = mkEnableOption "Whether or not to configure deluge";
    };

  config = mkIf cfg.enable {
    services.deluge = {
      enable = true;
      user = "arr";
      group = "arr";
      openFirewall = true;
    };
  };
}
