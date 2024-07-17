{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.nextcloud;
in
with lib;
with lib.${namespace};
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
      email = mkOption {
        type = types.str;
        default = "admin@localhost";
        description = "Email address for Let's Encrypt certificates";
      };
    };
  };

  config = mkIf cfg.enable {

    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.defaultPassword = {
        owner = "nextcloud";
      };
    };

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud28;
      hostName = cfg.hostName;
      settings.trusted_domains = cfg.trusted_domains;
      appstoreEnable = true;
      config.adminpassFile = "run/secrets/defaultPassword";
    };
    services.nginx = nxHost cfg.hostName;
    security.acme = {
      acceptTerms = true;
      certs = {
        ${cfg.hostName}.email = cfg.email;
      };
    };
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}

