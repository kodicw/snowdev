{ lib
, config
, namespace
, ...
}:
with lib.${namespace};
let
  cfg = config.${namespace}.services.forgejo;
in
{
  options.${namespace}.services.forgejo = {
    enable = lib.mkEnableOption "ForgeJo";
    disableRegistration = lib.mkOption {
      type = libtypes.bool;
      default = true;
      description = "";
    };
  };

  config = lib.mkIf cfg.enable {
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
    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.forgejoPassword.owner = "forgejo";
    };
    systemd.services.forgejo.preStart = ''
        admin="${lib.getExe config.services.forgejo.package} admin user"
      $admin create --admin --email "root@admin.com" --username admin --password "$(tr -d '\n' < ${config.sops.secrets.forgejoPassword.path})" || true
    '';
  };
}

