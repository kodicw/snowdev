{ config
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.plasma;
in
{
  options = {
    ${namespace}.desktop.plasma = {
      enable = lib.mkEnableOption "Plasma Desktop";
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      displayManager.sddm.enable = true;
      xserver = {
        desktopManager.plasma5.enable = true;
        enable = true;
      };
    };
  };
}

