{ config, lib, pkgs, namespace, ... }:
let
  phoenixPackages = with pkgs; [
    google-chrome
    streamdeck-ui
    obs-studio
    unityhub
    blender
  ];
  cfg = config.${namespace}.user.phoenix;
in
with lib;
{
  options = {
    ${namespace}.user.phoenix.enable = mkEnableOption "Enable Phoenix";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        Phoenix = {
          isNormalUser = true;
          description = "Boo";
          extraGroups = [ "networkmanager" "wheel" "libvertd" ];
          packages = phoenixPackages;
        };
      };
    };
  };
}

