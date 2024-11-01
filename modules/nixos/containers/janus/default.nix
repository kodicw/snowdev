{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.janus;
in
with lib;
{
  options = {
    ${namespace}.containers.janus = {
      enable = mkEnableOption "Enable Janus";
      localAddress = mkOption {
        type = types.str;
        default = "192.168.1.55/24";
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
    containers."janus" = {
      privateNetwork = true;
      hostBridge = cfg.hostBridge; # Specify the bridge name
      localAddress = cfg.localAddress;
      config = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          vim
          wget
          cmake
          git
          gtk-doc
          libmicrohttpd
          libnice
          (janus-gateway.overrideAttrs {
            configureFlags = [
              "--disable-rabbitmq"
              "--disable-mqtt"
              "--disable-plugin-recordplay"
            ];
          })
          # libsrtp
          # gtk-doc-tools
          # aptitude
        ];
        environment.etc."janus".source = ./conf;
        systemd.services.janus-gateway = {
          description = "Janus WebRTC Server";
          after = [ "network.target" ];
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.janus-gateway}/bin/janus -o --configs-folder=/etc/janus";
            Restart = "always";
            LimitNOFILE = 65536;
          };
        };
        services.openssh.enable = true;
        system.stateVersion = "24.05";
      };
    };
  };
}
