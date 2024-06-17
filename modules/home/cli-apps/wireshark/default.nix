{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.wireshark;
  in
  {
  options.${namespace}.cli-apps.wireshark = with types;
  {
  enable = mkEnableOption "Whether or not to enable wireshark.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ wireshark ]; };
  }