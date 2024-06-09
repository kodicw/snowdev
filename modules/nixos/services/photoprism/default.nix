{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.photoprism;
in
with lib;
{
  options = {
    ${namespace}.services.photoprism.enable = mkEnableOption "Photoprism";
  };
  config = mkIf cfg.enable
    {
      services.photoprism = {
        enable = true;
        port = 2342;
        originalsPath = "/var/lib/private/photoprism/originals";
        address = "0.0.0.0";
        settings = {
          PHOTOPRISM_ADMIN_USER = "admin";
          # PHOTOPRISM_ADMIN_PASSWORD = "temp123";
          PHOTOPRISM_DEFAULT_LOCALE = "en";
          PHOTOPRISM_UPLOAD_NSFW = "true";
        };
      };
      networking.firewall.allowedTCPPorts = [ 2342 ];
    };
}

