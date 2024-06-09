{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.steam;
in
{
  options.${namespace}.apps.steam = {
    enable = mkEnableOption "Whether or not to enable support for Steam.";
  };

  config = mkIf cfg.enable {
    programs = {
      steam.enable = true;
      steam.remotePlay.openFirewall = true;
      steam.dedicatedServer.openFirewall = true;
      gamemode.enable = true;
      gamescope.enable = true;
    };

    hardware.steam-hardware.enable = true;

    # Enable GameCube controller support.
    services.udev.packages = [ pkgs.dolphinEmu ];

    environment.systemPackages = with pkgs; [
      steam
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
  };
}
