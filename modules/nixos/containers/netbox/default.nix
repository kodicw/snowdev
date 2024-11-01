{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.netbox;
in
with lib;
{
  options = {
    ${namespace}.containers.netbox = {
      enable = mkEnableOption "enable netbox container";
    };
  };
  config = lib.mkIf cfg.enable {
    # sops = {
    #   defaultSopsFormat = "json";
    #   defaultSopsFile = ../../../../secrets/secrets.json;
    #   age.keyFile = /home/charles/.config/sops/age/keys.txt;
    #   secrets.netboxPassword.owner = "librenms";
    # };
    containers."netbox" = {
      # extraFlags = [ "-U" ];
      autoStart = true;
      ephemeral = false;
      # bindMounts."/secret/password" = {
      #   hostPath = "${config.sops.secrets.netboxPassword.path}";
      #   isReadOnly = true;
      # };
      forwardPorts = [{
        hostPort = 8001;
        containerPort = 8001;
        protocol = "tcp";
      }];
      config = { ... }: {
        services.netbox = {
          enable = true;
          secretKeyFile = "${pkgs.writeText "secret" "90331322d094320b2addd4afddb7769de82eec15ab233b48f905aee559476493e7e2652a7625e3455e1963aecfc08c410e8"}";
          port = 8001;

        };
        time.timeZone = "America/Los_Angeles";
        networking.firewall.allowedTCPPorts = [ 8001 ];
        system.stateVersion = "24.05";
      };
    };
  };
}
