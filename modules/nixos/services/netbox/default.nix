{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.netbox;
in
{
  options.${namespace}.services.netbox = with types;
    {
      enable = mkEnableOption "Whether or not to configure netbox";
    };
  config = mkIf cfg.enable {
    users.users.nginx.extraGroups = [ "netbox" ];
    users.groups.netbox.members = [ "nginx" ];
    services.netbox.enable = true;
    services.netbox.secretKeyFile = "${pkgs.writeText "secret" "90331322d094320b2addd4afddb7769de82eec15ab233b48f905aee559476493e7e2652a7625e3455e1963aecfc08c410e8"}";
    services.nginx = {
      enable = true;
      recommendedTlsSettings = true;
      clientMaxBodySize = "25m";
      virtualHosts."netbox.declarativepenguin.com" = {
        locations = {
          "/" = {
            proxyPass = "http://[::1]:8001";
            # proxyPass = "http://${config.services.netbox.listenAddress}:${config.services.netbox.port}";
          };
          "/static/" = { alias = "${config.services.netbox.dataDir}/static/"; };
        };
        forceSSL = true;
        enableACME = true;
        serverName = "netbox.declarativepenguin.com";
      };
    };
  };
}
