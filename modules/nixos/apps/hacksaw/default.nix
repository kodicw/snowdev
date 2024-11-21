{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.hacksaw;
  in
  {
  options.${namespace}.apps.hacksaw = with types;
  {
  enable = mkEnableOption "Whether or not to enable hacksaw.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ hacksaw ]; };
  }