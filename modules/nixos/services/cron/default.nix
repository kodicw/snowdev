{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.cron;
in
{
  options.${namespace}.services.cron = with types;
    {
      enable = mkEnableOption "Whether or not to configure cron";
    };

  config = mkIf cfg.enable {
    services.cron.enable = true;
  };
}
