{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.kdeconnect;
in
{
  options.${namespace}.apps.kdeconnect = {
    enable = mkEnableOption "Whether or not to enable kdeconnect.";
  };

  config = mkIf cfg.enable {
    programs.kdeconnect.enable = true;
  };
}
