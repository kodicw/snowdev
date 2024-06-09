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
  # Install Hyperland and fix some stuff
  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    environment.sessionVariables = {
      # Fix invisible cursor
      WLR_NO_HARDWARE_CURSORS = "1";
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
    environment.systemPackages = with pkgs; [
      # Hyprland 
      hypridle
      hyprlock
      polkit # for auth
      rofi # Application search bar
      wl-clipboard
      xwaylandvideobridge
      xdg-desktop-portal
      xdg-desktop-portal-kde
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };
}

