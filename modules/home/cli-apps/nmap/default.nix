{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.nmap;
in
{
  options.${namespace}.cli-apps.nmap = with types;
    {
      enable = mkEnableOption "Whether or not to enable nmap.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ nmap ]; };
}
