{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.zabbixServer;
  zabbix-web = config.services.zabbixWeb;
in
{
  options.${namespace}.services.zabbixServer = with types;
    {
      enable = mkEnableOption "Whether or not to configure zabbixServer";
      hostName = mkOption {
        type = types.str;
        default = "localhost";
        description = "The hostname of the zabbix server";
      };
      email = mkOption {
        type = types.str;
        default = "example@dot.com";
        description = "The email address to use for the zabbix server";
      };
    };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 10051 80 443 ];
    services = {
      zabbixServer = {
        enable = true;
        openFirewall = true;
      };
      zabbixWeb = {
        enable = true;
        virtualHost = {
          hostName = cfg.hostName;
          adminAddr = cfg.email;
          forceSSL = true;
          enableACME = true;
        };
      };
      zabbixAgent = {
        enable = true;
        server = "localhost";
      };
    };
    security.acme = {
      acceptTerms = true;
      certs = {
        ${zabbix-web.virtualHost.hostName}.email = cfg.email;
      };
    };
  };
}
