{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.jelly;
in
with lib;
{
  options = {
    ${namespace}.containers.jelly = {
      enable = mkEnableOption "Enable Janus";
      localAddress = mkOption {
        type = types.str;
        default = "192.168.1.50/24";
        description = "Local address to bind Janus to";
      };
      hostBridge = mkOption {
        type = types.str;
        default = "br0";
        description = "Host bridge to bind Janus to";
      };
      privateNetwork = mkOption {
        type = types.bool;
        default = true;
        description = "Enable private network for Janus";
      };
    };
  };
  config = mkIf cfg.enable {
    containers."jelly" = {
      # extraFlags = [ "--privileged" ];
      autoStart = true;
      ephemeral = false;
      bindMounts."/media" = {
        hostPath = "/media";
        isReadOnly = false;
      };
      # allowedDevices = [
      #   {
      #     modifier = "rw";
      #     node = "/dev/sdb1";
      #   }
      # ];
      additionalCapabilities = [
        "all"
      ];
      privateNetwork = true;
      hostBridge = cfg.hostBridge;
      localAddress = cfg.localAddress;
      config = { ... }: {
        users.users = {
          arr = {
            isSystemUser = true;
            group = "arr";
            uid = 6969;
          };
        };
        users.groups = {
          arr = {
            gid = 6969;
            members = [ "arr" ];
          };
        };
        services.tailscale.enable = true;
        services.tailscale.interfaceName = "userspace-networking";
        services.tailscale.useRoutingFeatures = "client";
        services.jellyfin.enable = true;
        services.jellyfin.openFirewall = true;
        services.jellyseerr.enable = true;
        services.jellyseerr.openFirewall = true;
        services.avahi = {
          nssmdns = true; # Allows software to use Avahi to resolve.
          enable = true;
          publish = {
            enable = true;
            addresses = true;
            workstation = true;
          };
        };
        services.resolved.enable = true;
        networking = {
          hostName = "jelly";
          interfaces."eth0".useDHCP = true;
          useHostResolvConf = false;
          firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
          firewall.allowedUDPPorts = [ config.services.tailscale.port ];
          firewall.checkReversePath = "loose";
        };
        system.stateVersion = "24.05";
      };
    };
  };
}
