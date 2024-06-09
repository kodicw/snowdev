{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.discord;
in
{
  options.${namespace}.apps.discord = {
    enable = mkEnableOption "Whether or not to enable discord.";
  };

  config = mkIf cfg.enable { environment.systemPackages = with pkgs; [ discord ]; };
}
