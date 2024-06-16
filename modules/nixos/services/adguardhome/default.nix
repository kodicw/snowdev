{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.adguardHome;
in
with lib;
{
  options = {
    ${namespace}.services.adguardHome = {
      enable = mkEnableOption "Enable Adguard Home";
      port = mkOption {
        type = types.port;
        default = 8000;
        description = "Port to bind Adguard Home to";
      };
      host = mkOption {
        type = types.str;
        default = "0.0.0.0";
        description = "Host to bind Adguard Home to";
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      adguardian
    ];
    services.adguardhome = {
      enable = true;
      mutableSettings = true;
      openFirewall = true;
      settings = {
        host = cfg.host;
        port = cfg.port;
      };
    };
  };
}

