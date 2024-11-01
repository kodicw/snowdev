{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.terraria;
in
{
  options.${namespace}.services.terraria = with types;
    {
      enable = mkEnableOption "Whether or not to configure terraria";
    };

  config = mkIf cfg.enable {
    services.terraria.enable = true;
    services.terraria.openFirewall = true;
    services.terraria.port = 7777;
    services.terraria.worldPath = "/var/lib/terraria/.local/share/Terraria/Worlds/wasabi.wld";
    services.terraria.password = "pip-pip-y4y-and-sip";
    services.terraria.maxPlayers = 8;
    services.terraria.noUPnP = true;
  };
}
