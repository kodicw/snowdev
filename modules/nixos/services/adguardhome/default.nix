{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.adguardHome;
in
with lib;
{
  options = {
    ${namespace}.services.adguardHome.enable = mkEnableOption "Enable Adguard Home";
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
        bind_host = "0.0.0.0";
        bind_port = 8000;
      };
    };
  };
}

