{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.phoneinfoga;
in
with lib;
{
  options = {
    ${namespace}.containers.phoneinfoga = {
      enable = mkEnableOption "enable phoneinfoga container";
    };
  };
  config = lib.mkIf cfg.enable {
    # Runtime
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      defaultNetwork.settings = {
        # Required for container networking to be able to use names.
        dns_enabled = true;
      };
    };

    # Enable container name DNS for non-default Podman networks.
    # https://github.com/NixOS/nixpkgs/issues/226365
    networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

    virtualisation.oci-containers.backend = "podman";

    # Containers
    virtualisation.oci-containers.containers."phoneinfoga" = {
      image = "sundowndev/phoneinfoga:latest";
      ports = [
        "5000:5000/tcp"
      ];
      cmd = [ "serve" ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=phoneinfoga"
        "--network=phoneinfoga_default"
      ];
    };
    systemd.services."podman-phoneinfoga" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "on-failure";
      };
      after = [
        "podman-network-phoneinfoga_default.service"
      ];
      requires = [
        "podman-network-phoneinfoga_default.service"
      ];
      partOf = [
        "podman-compose-phoneinfoga-root.target"
      ];
      wantedBy = [
        "podman-compose-phoneinfoga-root.target"
      ];
    };

    # Networks
    systemd.services."podman-network-phoneinfoga_default" = {
      path = [ pkgs.podman ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "podman network rm -f phoneinfoga_default";
      };
      script = ''
        podman network inspect phoneinfoga_default || podman network create phoneinfoga_default
      '';
      partOf = [ "podman-compose-phoneinfoga-root.target" ];
      wantedBy = [ "podman-compose-phoneinfoga-root.target" ];
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    systemd.targets."podman-compose-phoneinfoga-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
