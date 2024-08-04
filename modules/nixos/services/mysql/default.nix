{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.mysql;
in
{
  options.${namespace}.services.mysql =
    {
      enable = mkEnableOption "Whether or not to configure mysql";
      user = mkOption {
        type = types.str;
        default = "magicdb";
      };
      package = mkOption {
        type = types.package;
        default = pkgs.mariadb;
      };
    };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFormat = "json";
      defaultSopsFile = ../../../../secrets/secrets.json;
      age.keyFile = /home/charles/.config/sops/age/keys.txt;
      secrets.mysqlpassword = {
        owner = "mysql";
      };
    };
    services.mysql = {
      enable = true;
      package = cfg.package;
    };
    users.mysql = {
      passwordFile = /run/secrets/mysqlpassword;
      user = cfg.user;
    };
  };
}
