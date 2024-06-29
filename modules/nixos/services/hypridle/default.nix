{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.hypridle;
in
{
  options.${namespace}.services.hypridle = with types;
    {
      enable = mkEnableOption "Whether or not to configure hypridle";
    };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
    };
  };
}
