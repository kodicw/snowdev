{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.odoo;
in
{
  options.${namespace}.services.odoo = with types;
    {
      enable = mkEnableOption "Whether or not to configure odoo";
      domain = mkOption {
        type = types.str;
        default = "safehavenesthetics.com";
        description = "The domain to use for odoo";
      };
      email = mkOption {
        type = types.str;
        default = "kodicw@gmail.com";
      };
    };

  config = mkIf cfg.enable {
    services.nginx = nxHost cfg.domain;
    services.odoo = {
      enable = true;
      domain = cfg.domain;
    };
  };
}

