{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.librenms;
in
with lib;
{
  options = {
    ${namespace}.containers.librenms = {
      enable = mkEnableOption "enable librenms container";
    };
  };
  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.librenmsPassword.owner = "librenms";
    };
    users.groups.librenms = {
      gid = 999;
    };
    users.users.librenms = {
      isSystemUser = true;
      group = "librenms";
      uid = 999;
    };
    containers."librenms" = {
      # extraFlags = [ "-U" ];
      autoStart = true;
      bindMounts."/secret/password" = {
        hostPath = "${config.sops.secrets.librenmsPassword.path}";
        isReadOnly = true;
      };

      forwardPorts = {
        hoatPort = 80;
        containerPort = 80;
        protocol = "tcp";
      };
      config = { ... }: {
        services.librenms = {
          enable = true;
          database.passwordFile = "/secret/password";
          database.createLocally = true;
          extraConfig = ''
            $config['discovery_by_ip'] = true;
            $config['snmp']['community'][] = "home";
          '';
        };
        time.timeZone = "America/Los_Angeles";
        networking.firewall.allowedTCPPorts = [ 80 ];
        system.stateVersion = "24.05";
      };
    };
  };
}
