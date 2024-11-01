{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.ark;
in
{
  options.${namespace}.cli-apps.ark = with types;
    {
      enable = mkEnableOption "Whether or not to enable ark.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ ark ]; };
}
