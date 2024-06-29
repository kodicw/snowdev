{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.firefox;
in
{
  options.${namespace}.apps.firefox = with types;
    {
      enable = mkEnableOption "Whether or not to enable firefox.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ firefox ]; };
}
