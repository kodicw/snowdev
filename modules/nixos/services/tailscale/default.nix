{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.tailscale;
in
{
  options.${namespace}.services.tailscale = with types; {
    enable = mkEnableOption "Whether or not to configure Tailscale";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ tailscale ];
    services.tailscale = enabled;
    networking = {
      firewall = {
        trustedInterfaces = [ config.services.tailscale.interfaceName ];
        allowedUDPPorts = [ config.services.tailscale.port ];
        # Strict reverse path filtering breaks Tailscale exit node use and some subnet routing setups.
        checkReversePath = "loose";
      };
      networkmanager.unmanaged = [ "tailscale0" ];
    };
  };
}
