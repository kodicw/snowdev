{ pkgs, config, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.xrdp;
in
with lib;
{
  options = {
    ${namespace}.services.xrdp = {
      enable = mkEnableOption "Enable xrdp";
      port = mkOption {
        type = types.port;
        default = 3389;
        description = "Port to listen on";
      };
      wm = mkOption {
        type = types.str;
        default = "gnome-remote-desktop";
        description = "Window manager to use";
      };
    };
  };
  config = mkIf cfg.enable {
    services.xrdp = {
      enable = true;
      port = cfg.port;
      openFirewall = true;
      defaultWindowManager = cfg.wm;
    };
  };
}

