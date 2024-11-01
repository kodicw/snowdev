{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.swappy;
in
{
  options.${namespace}.cli-apps.swappy = with types;
    {
      enable = mkEnableOption "Whether or not to enable swappy.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ swappy ]; };
}
