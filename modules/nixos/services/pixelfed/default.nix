{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.pixelfed;
in
{
  options.${namespace}.services.pixelfed = with types;
    {
      enable = mkEnableOption "Whether or not to configure pixelfed";
      domain = mkOption {
        type = types.str;
        default = "pix.declarativepenguin.com";
        description = "The domain to use for pixelfed";
      };
      email = mkOption {
        type = types.str;
        default = "kodicw@gmail.com";
        description = "The email to use for pixelfed";
      };
    };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    security.acme = {
      acceptTerms = true;
      certs = {
        ${cfg.domain}.email = cfg.email;
      };
    };
    services.pixelfed = {
      enable = true;
      nginx = {
        enableACME = true;
        forceSSL = true;
        serverName = cfg.domain;
      };
      domain = cfg.domain;
      secretFile = (pkgs.writeText "secrets.env" ''
        # Snakeoil secret, can be any random 32-chars secret via CSPRNG.
        APP_KEY=adKK9EcY8Hcj3PLU7rzG9rJ6KKTOtYlA
      '');
    };
  };
}
