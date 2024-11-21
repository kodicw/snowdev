{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.test;
in
{
  options.${namespace}.services.test = with types; {
    enable = mkEnableOption "Whether or not to configure mullvad";
  };

  config = mkIf cfg.enable {
    services.test.enable = true;
  };
}
