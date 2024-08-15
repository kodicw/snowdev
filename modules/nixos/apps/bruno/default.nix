{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.bruno;
in
{
  options.${namespace}.apps.bruno = with types;
    {
      enable = mkEnableOption "Whether or not to enable bruno.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ bruno ]; };
}
