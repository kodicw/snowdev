{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.kdenlive;
in
{
  options.${namespace}.apps.kdenlive = with types;
    {
      enable = mkEnableOption "Whether or not to enable kdenlive.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ kdenlive ]; };
}
