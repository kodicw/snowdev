{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.protonmail-desktop;
in
{
  options.${namespace}.apps.protonmail-desktop = with types;
    {
      enable = mkEnableOption "Whether or not to enable protonmail-desktop.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ protonmail-desktop ]; };
}
