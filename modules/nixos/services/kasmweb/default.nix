{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.kasmweb;
in
{
  options.${namespace}.services.kasmweb = with types;
    {
      enable = mkEnableOption "Whether or not to configure kasmweb";
    };

  config = mkIf cfg.enable {
    services.kasmweb = {
      enable = true;
      listenPort = 8080;
    };
  };
}
