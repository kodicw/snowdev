{ config
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.bigscreen;
in
{
  options = {
    ${namespace}.desktop.bigscreen = {
      enable = lib.mkEnableOption "Plasma Desktop";
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      displayManager.sddm.enable = true;
      xserver = {
        desktopManager.plasma5.bigscreen.enable = true;
        enable = true;
      };
    };
  };
}

