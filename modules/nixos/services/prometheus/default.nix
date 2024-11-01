{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.prometheus;
in
{
  options.${namespace}.services.prometheus = with types;
    {
      enable = mkEnableOption "Whether or not to configure prometheus";
    };
  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      exporters = {
        node = {
          enable = true;
          enabledCollectors = [ "systemd" ];
          port = 9100;
        };
      };
      scrapeConfigs = [{
        job_name = "mainframe";
        static_configs = [
          {
            targets = [ "localhost:9100" ];
          }
        ];
      }];
    };
  };
}
