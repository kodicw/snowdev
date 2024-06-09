{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.octoprint;
in
with lib;
{
  options = {
    ${namespace}.services.octoprint = {
      enable = mkEnableOption "Enable Octoprint";
    };
  };

  config = mkIf cfg.enable {
    services.octoprint = {
      openFirewall = true;
      enable = true;
      port = 8383;
    };
  };
}

