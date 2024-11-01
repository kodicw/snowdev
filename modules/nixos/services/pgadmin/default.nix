{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.pgadmin;
in
{
  options.${namespace}.services.pgadmin = with types;
    {
      enable = mkEnableOption "Whether or not to configure pgadmin";
    };

  config = mkIf cfg.enable {
    services.pgadmin = {
      enable = true;
      port = 5050;
      initialEmail = "root@admin.com";
      openFirewall = true;
      initialPasswordFile = "/run/secrets/pgadminpassword";
    };
    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.pgadminpassword.owner = "pgadmin";
    };
  };
}
