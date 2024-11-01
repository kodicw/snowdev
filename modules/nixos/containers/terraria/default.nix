{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.terraria;
in
with lib;
{
  options = {
    ${namespace}.containers.terraria = {
      enable = mkEnableOption "enable terraria container";
    };
  };
  config = lib.mkIf cfg.enable {
    # sops = {
    #   defaultSopsFormat = "json";
    #   defaultSopsFile = ../../../../secrets/secrets.json;
    #   age.keyFile = /home/charles/.config/sops/age/keys.txt;
    #   secrets.terrariaPassword.owner = "librenms";
    # };
    containers."terraria" = {
      # extraFlags = [ "-U" ];
      autoStart = true;
      ephemeral = true;
      forwardPorts = {
        hoatPort = 7777;
        containerPort = 7777;
        protocol = "tcp";
      };
      config = { ... }: {
        services.terraria = {
          enable = true;
          openFirewall = true;
          port = 7777;

        };
        virtualisation.docker.enable = true;
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "terraria-server"
        ];
        environment.systemPackages = with pkgs; [ tmux terraria-server ];
        time.timeZone = "America/Los_Angeles";
        networking.firewall.allowedTCPPorts = lib.mkDefault [ 7777 ];
        networking.firewall.allowedUDPPorts = lib.mkDefault [ 7777 ];
        system.stateVersion = "24.05";
      };
    };
  };
}
