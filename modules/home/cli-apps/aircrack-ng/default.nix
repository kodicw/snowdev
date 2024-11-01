{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.aircrack-ng;
in
{
  options.${namespace}.cli-apps.aircrack-ng = with types;
    {
      enable = mkEnableOption "Whether or not to enable aircrack-ng.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ aircrack-ng ]; };
}
