{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.forgejo;
in
{
  options.${namespace}.services.forgejo = with types;
    {
      enable = mkEnableOption "Whether or not to configure forgejo";
    };

  config = mkIf cfg.enable {
    services.forgejo.enable = true;
  };
}
