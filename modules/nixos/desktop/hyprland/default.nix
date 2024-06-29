{ config
, pkgs
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.hyprland;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.desktop.hyprland.enable = mkEnableOption "Enable Hyprland Desktop";
  };
  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
  };
}

