{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.nautilus;
  in
  {
  options.${namespace}.apps.nautilus = with types;
  {
  enable = mkEnableOption "Whether or not to enable nautilus.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ gnome.nautilus ]; };
  }
