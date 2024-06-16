{ config, lib, pkgs, namespace, inputs, ... }:
let
  cfg = config.${namespace}.stylix;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.stylix = {
      enable = mkEnableOption "stylix";
      polarity = mkOption {
        type = types.str;
        default = "dark";
        description = ''
          The color scheme to use for the Stylix theme.
        '';
      };
      image = mkOption {
        type = types.path;
        default = ./windows-95-japan-moewalls-com.png;
        description = ''
          The image to use for the Stylix theme.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    stylix = {
      image = cfg.image;
      polarity = cfg.polarity;
      targets.nixos-icons.enable = false;
    };
  };
}

