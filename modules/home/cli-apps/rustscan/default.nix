{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.rustscan;
in
{
  options.${namespace}.cli-apps.rustscan = with types;
    {
      enable = mkEnableOption "Whether or not to enable rustscan.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ rustscan ]; };
}
