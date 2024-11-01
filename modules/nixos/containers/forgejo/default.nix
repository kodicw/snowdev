{ namespace, config, lib, inputs, pkgs, ... }:
let
  cfg = config.${namespace}.containers.forgejo;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.containers.forgejo = {
      enable = mkEnableOption "Enable Janus";
      localAddress = mkOption {
        type = types.str;
        default = "192.168.1.52/24";
        description = "Local address to bind Janus to";
      };
      hostBridge = mkOption {
        type = types.str;
        default = "br0";
        description = "Host bridge to bind Janus to";
      };
      privateNetwork = mkOption {
        type = types.bool;
        default = true;
        description = "Enable private network for Janus";
      };
      disableRegistration = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "";
      };
    };
  };
  config = mkIf cfg.enable {
    users.users.forgejo = {
      isSystemUser = true;
      group = "forgejo";
      uid = 10001;
    };
    users.groups.forgejo = {
      gid = 10001;
      members = [ "forgejo" ];
    };
    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.forgejoPassword.owner = "forgejo";
    };
    containers."forgejo" =
      {
        extraFlags = [ "-U" ];
        autoStart = true;
        # ephemeral = false;
        enableTun = true;
        privateNetwork = true;
        hostBridge = cfg.hostBridge;
        localAddress = cfg.localAddress;
        bindMounts."/secret/password" = {
          hostPath = "${config.sops.secrets.forgejoPassword.path}";
          isReadOnly = true;
        };
        config = { config, ... }: {
          services.forgejo = {
            enable = true;
            database.type = "postgres";
            # Enable support for Git Large File Storage
            lfs.enable = true;
            settings = {
              server = {
                DOMAIN = "git.declarativepenguin.com";
                # You need to specify this to remove the port from URLs in the web UI.
                ROOT_URL = "http://git.declarativepenguin.com/";
                HTTP_PORT = 3000;
              };
              # You can temporarily allow registration to create an admin user.
              service.DISABLE_REGISTRATION = cfg.disableRegistration;
              # Add support for actions, based on act: https://github.com/nektos/act
              actions = {
                ENABLED = true;
                DEFAULT_ACTIONS_URL = "github";
              };
              # Sending emails is completely optional
              # You can send a test email from the web UI at:
              # Profile Picture > Site Administration > Configuration >  Mailer Configuration 
              #     mailer = {
              #       ENABLED = true;
              #       SMTP_ADDR = "mail.example.com";
              #       FROM = "noreply@${srv.DOMAIN}";
              #       USER = "noreply@${srv.DOMAIN}";
              #     };
              #   };
              #   mailerPasswordFile = config.age.secrets.forgejo-mailer-password.path;
            };
            #
            # age.secrets.forgejo-mailer-password = {
            #   file = ../secrets/forgejo-mailer-password.age;
            #   mode = "400";
            #   owner = "forgejo";
          };
          systemd.services.forgejo.preStart = ''
              admin="${lib.getExe config.services.forgejo.package} admin user"
            $admin create --admin --email "root@admin.com" --username admin --password "$(tr -d '\n' < /secret/password)" || true
          '';
          services.resolved.enable = true;
          services.tailscale.enable = true;
          services.tailscale.interfaceName = "userspace-networking";
          services.tailscale.useRoutingFeatures = "client";

          networking = {
            hostName = "forgejo";
            interfaces."eth0".useDHCP = true;
            useHostResolvConf = false;
            firewall.allowedTCPPorts = [ 3000 ];
            firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
            firewall.allowedUDPPorts = [ config.services.tailscale.port ];
            firewall.checkReversePath = "loose";
          };
          system.stateVersion = "24.05";
        };
      };
  };
}
