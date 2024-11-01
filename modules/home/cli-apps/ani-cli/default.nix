{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.ani-cli;
in
{
  options.${namespace}.cli-apps.ani-cli = with types;
    {
      enable = mkEnableOption "Whether or not to enable ani-cli.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ ani-cli ]; };
}
