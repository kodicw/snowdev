{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.stacer;
in
{
  options.${namespace}.apps.stacer = with types; {
    enable = mkEnableOption "Whether or not to enable Stacer.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ stacer ]; };
}
