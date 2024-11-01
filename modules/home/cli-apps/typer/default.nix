{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.typer;
in
{
  options.${namespace}.cli-apps.typer = with types;
    {
      enable = mkEnableOption "Whether or not to enable typer.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ typer ]; };
}
