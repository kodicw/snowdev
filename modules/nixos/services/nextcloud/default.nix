{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.nextcloud;
in
with lib;
{
  options = {
    ${namespace}.services.nextcloud = {
      enable = mkEnableOption "Enable Nextcloud";
      hostName = mkOption {
        type = types.str;
        default = "localhost";
        description = "The hostname of the Nextcloud server";
      };
      trusted_domains = mkOption {
        type = types.listOf types.str;
        default = [ "localhost" ];
        description = "List of trusted domains for Nextcloud";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.etc."nextcloud-admin-pass".text = "password"; #FIX: need to add check for file and add manually
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud28;
      hostName = cfg.hostName;
      settings.trusted_domains = cfg.trusted_domains;
      appstoreEnable = true;
      config.adminpassFile = "/etc/nextcloud-admin-pass";
    };
  };
}

