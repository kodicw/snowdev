{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.metasploit;
  in
  {
  options.${namespace}.cli-apps.metasploit = with types;
  {
  enable = mkEnableOption "Whether or not to enable metasploit.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ metasploit ]; };
  }