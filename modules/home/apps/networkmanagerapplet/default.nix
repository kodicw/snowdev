{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.networkmanagerapplet;
  in
  {
  options.${namespace}.apps.networkmanagerapplet = with types;
  {
  enable = mkEnableOption "Whether or not to enable networkmanagerapplet.";
  };
  config =
    mkIf cfg.enable { home.packages = with pkgs; [ networkmanagerapplet ]; };
  }