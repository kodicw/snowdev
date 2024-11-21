{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.shotgun;
  in
  {
  options.${namespace}.apps.shotgun = with types;
  {
  enable = mkEnableOption "Whether or not to enable shotgun.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ shotgun ]; };
  }