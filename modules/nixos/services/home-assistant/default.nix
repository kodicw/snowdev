{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.home-assistant;
in
{
  options.${namespace}.services.home-assistant = with types;
    {
      enable = mkEnableOption "Whether or not to configure home-assistant";
      openFirewall = mkEnableOption "Whether or not to open the firewall";
    };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ 8123 ];
    services.home-assistant = {
      enable = true;
      extraComponents = [
        # Components required to complete the onboarding
        "esphome"
        "sonarr"
        "govee_light_local"
        "govee_ble"
        "radarr"
        "jellyfin"
        "androidtv"
        "tailscale"
        "opnsense"
        "roborock"
        "ollama"
        "piper"
        "whisper"
        "wyoming"
        "systemmonitor"
        "system_health"
        "system_log"
        "wled"
        "spotify"
        "google"
        "google_tasks"
        "google_assistant"
        "met"
        "epson"
        "radio_browser"
      ];
      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = { };
      };
    };
  };
}
