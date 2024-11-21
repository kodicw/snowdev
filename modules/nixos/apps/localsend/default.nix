{
 config
, pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.localsend;
in
{
  options.${namespace}.apps.localsend = with types;
    {
      enable = mkEnableOption "Whether or not to enable localsend.";
    };

  config =
    mkIf cfg.enable {
      environment.systemPackages = [ pkgs.localsend ];
  };
}
