{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.armcord;
in
{
  options.${namespace}.apps.armcord = {
    enable = mkEnableOption "Whether or not to enable armcord.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ legcord ]; };
}
