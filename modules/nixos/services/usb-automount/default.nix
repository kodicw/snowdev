{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.usb-automount;
in
{
  options.${namespace}.services.usb-automount = with types;
    {
      enable = mkEnableOption "Whether or not to configure usb-automount";
    };

  config = mkIf cfg.enable {
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
