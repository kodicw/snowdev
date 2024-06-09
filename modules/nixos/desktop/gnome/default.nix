{ config
, lib
, pkgs
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.gnome;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.desktop.gnome.enable = mkEnableOption "Enable GNOME desktop environment";
  };
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
 

