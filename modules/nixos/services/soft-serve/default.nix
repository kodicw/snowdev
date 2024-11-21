{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.soft-serve;
in
with lib;
{
  options = {
    ${namespace}.services.soft-serve = {
      enable = mkEnableOption "Enable Soft-Serve git server";
      name = mkOption {
        type = types.str;
        default = "Daddy's repos";
        description = "Name of the server to be displayed";
      };
      ssh_port = mkOption {
        type = types.str;
        default = ":23231";
        description = "Port to listen for SSH connections on";
      };
      http_port = mkOption {
        type = types.str;
        default = ":23232";
        description = "Port to listen for HTTP connections on";
      };
      domain = mkOption {
        type = types.str;
        default = "soft-serve.${config.networking.hostName}";
        description = "Domain name to use for public URLs";
      };
      initial_admin_keys = mkOption {
        type = types.listOf types.str;
        default = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiDe2CMnDgWjXqMpQHxCSOmrjuAWwZazYPORZXlr2SF u0_a518@localhost"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv8kP8LWCSGweBHEl/AmxKMLat2Y2RWonKqDSO6RrWb charles@mainframe"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPNpbQzoQmh2GCk80r3CIftZHzvz/GEofHKrXCOXQ0hT nixos@nixos"
        ];
        description = "List of initial admin SSH keys";
      };
    };
  };

  config = mkIf cfg.enable {
    services.soft-serve = {
      enable = true;
      settings = {
        name = cfg.name;
        log_format = "text";
        ssh = {
          listen_addr = cfg.ssh_port;
          public_url = "ssh://${cfg.domain}${cfg.ssh_port}";
        };
        http = {
          listen_addr = cfg.http_port;
          public_url = "http://${cfg.domain}${cfg.http_port}";
        };
        stats.listen_addr = ":23233";
        jobs.mirror_pull = "@every 1h";
        initial_admin_keys = cfg.initial_admin_keys;
      };
    };
    networking.firewall.allowedTCPPorts = [ 23231 ];
  };
}
