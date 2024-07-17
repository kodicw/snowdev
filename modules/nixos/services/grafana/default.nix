{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.grafana;
in
{
  options.${namespace}.services.grafana = with types;
    {
      enable = mkEnableOption "Whether or not to configure grafana";
      port = mkOption {
        type = types.int;
        default = 3000;
        description = "The port to run grafana on";
      };
      domain = mkOption {
        type = types.str;
        default = "localhost";
        description = "The domain to run grafana on";
      };
      addr = mkOption {
        type = types.str;
        default = "127.0.0.1";
      };
    };

  config = mkIf cfg.enable {
    services.grafana = {
      enable = true;
      port = cfg.port;
      domain = cfg.domain;
      addr = cfg.addr;
    };
  };
}
