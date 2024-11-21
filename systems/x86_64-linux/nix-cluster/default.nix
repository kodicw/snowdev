{ lib
, namespace
, inputs
, ...
}:
let
  hostname = "nix-cluster";
in
{
  imports = [
    ./hardware.nix
    "${inputs.unstable}/nixos/modules/services/display-managers/ly.nix"
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  genix = with lib.${namespace}; {
    techstack = {
      server = enabled;
    };
    user = {
      charles = enabled;
      root = enabled;
    };
    system = {
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    hardware = {
      audio = enabled;
      network.container-net = {
        enable = true;
        interfaces = [ "eno1" ];
        staticIP = "192.168.1.134";
        containerInterfaces = [ "vb-jelly@if2" "vb-arr@if2" "vb-*" ];
      };
    };
    virtualisation.docker.enable = true;
    services = {
      openssh = enabled;
      ollama = enabled;
      tailscale = enabled;
      homepage = enabled;
      home-assistant = {
        enable = true;
        openFirewall = true;
      };
      # arr.users = enabled;
    };
    containers = {
      jelly.enable = true;
      arr.enable = true;
      # librenms.enable = true;
      phoneinfoga.enable = true;
      nagios.enable = true;
      forgejo.enable = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 8001 8080 8123 11434 ];
  networking.firewall.allowedUDPPorts = [ 11434 ];
  # boot.kernel = {
  #   sysctl = {
  #     "net.ipv4.conf.all.forwarding" = true;
  #     "net.ipv6.conf.all.forwarding" = false;
  #   };
  # };
  networking.hostName = hostname;
  system.stateVersion = "24.05";
}
