{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.ceph;
in
{
  options.${namespace}.services.ceph = with types;
    {
      enable = mkEnableOption "Whether or not to configure ceph";
    };

  config = mkIf cfg.enable {
    services.ceph = {
      enable = true;
      mon = {
        enable = true;
      };
      osd = {
        enable = true;
      };
    };
  };
}
