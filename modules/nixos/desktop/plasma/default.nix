{ config
, lib
, inputs
, namespace
, ...
}:
let
  cfg = config.${namespace}.desktop.plasma;
in
{
  imports = [
    "${inputs.unstable}/nixos/modules/services/display-managers/ly.nix"
  ];
  options = {
    ${namespace}.desktop.plasma = {
      enable = lib.mkEnableOption "Plasma Desktop";
    };
  };
  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        desktopManager.plasma5.enable = true;
        enable = true;
      };
      displayManager.ly = {
        enable = true;
        settings = {
          animation = "matrix";
        };
      };
      displayManager.execCmd = lib.mkForce "exec /run/current-system/sw/bin/ly";
    };
  };
}

