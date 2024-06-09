{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.vivaldi;
in
{
  options.${namespace}.apps.vivaldi = {
    enable = mkEnableOption "Whether or not to enable vivaldi.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ vivaldi ]; };
}
