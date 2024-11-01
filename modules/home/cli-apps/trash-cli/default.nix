{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.trash-cli;
in
{
  options.${namespace}.cli-apps.trash-cli = with types;
    {
      enable = mkEnableOption "Whether or not to enable trash-cli.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ trash-cli ]; };
}
