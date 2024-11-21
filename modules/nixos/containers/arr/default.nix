{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.arr;
in
with lib;
{
  options = {
    ${namespace}.containers.arr = {
      enable = mkEnableOption "Enable Janus";
      localAddress = mkOption {
        type = types.str;
        default = "192.168.1.51/24";
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
      dataDir = mkOption {
        type = types.path;
        default = "/var/lib/sonarr";
        description = "The directory where sonarr will store its data";
      };
    };
  };
  config = mkIf cfg.enable {
    containers."arr" = {
      additionalCapabilities = [ "all" ];
      autoStart = true;
      bindMounts."/media" = {
        hostPath = "/media";
        isReadOnly = false;
      };
      ephemeral = false;
      privateNetwork = true;
      enableTun = true;
      hostBridge = cfg.hostBridge;
      localAddress = cfg.localAddress;
      config = { ... }: {
        services = {
          prowlarr = {
            enable = true;
            openFirewall = true;
            #Port 9696;
          };
          sonarr = {
            enable = true;
            openFirewall = true;
            user = "arr";
            group = "arr";
            dataDir = cfg.dataDir;
            #Port = 8989;
          };
          radarr = {
            enable = true;
            user = "arr";
            group = "arr";
            openFirewall = true;
            #Port = 7878;
          };
          sabnzbd = {
            enable = true;
            user = "arr";
            group = "arr";
            openFirewall = true;
            #Port = 8080;
          };
          deluge = {
            enable = true;
            user = "arr";
            group = "arr";
            openFirewall = true;
            web.enable = true;
          };
          avahi = {
            nssmdns4 = true; # Allows software to use Avahi to resolve.
            enable = true;
            publish = {
              enable = true;
              addresses = true;
              workstation = true;
            };
          };
          tailscale.enable = true;
          tailscale.interfaceName = "userspace-networking";
          tailscale.useRoutingFeatures = "client";
          resolved.enable = true;
          openssh.enable = true;
        };
        users = {
          users = {
            root.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv8kP8LWCSGweBHEl/AmxKMLat2Y2RWonKqDSO6RrWb charles@mainframe" ];
            arr = {
              isSystemUser = true;
              group = "arr";
              uid = 6969;
            };
          };
          groups.arr = {
            gid = 6969;
            members = [ "arr" ];
          };
        };
        networking = {
          hostName = "arr";
          interfaces."eth0".useDHCP = true;
          useHostResolvConf = false;
          firewall.enable = true;
          firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
          firewall.allowedUDPPorts = [ config.services.tailscale.port ];
          firewall.checkReversePath = "loose";
        };
        nixpkgs.config.allowUnfree = true;
        system.stateVersion = "24.05";
      };
    };
  };
}
