{ pkgs
, config
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.plasma;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.desktop.plasma.enable = mkEnableOption "Plasma Desktop";
  };
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
    };
  };
}

