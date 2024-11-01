{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.tcpdump;
in
{
  options.${namespace}.cli-apps.tcpdump = with types;
    {
      enable = mkEnableOption "Whether or not to enable tcpdump.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ tcpdump ]; };
}
