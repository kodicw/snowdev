{ lib
, pkgs
, modulesPath
, namespace
, config
, ...
}:
let
  hostname = "traefik-nixnode";
in
with lib;
with lib.${namespace};
{
  imports = [
    ./hardware.nix
  ];
  genix = {
    techstack = {
      server = enabled;
    };
    user = {
      charles = enabled;
      root = enabled;
    };
    system = {
      boot.linode = enabled;
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    services = {
      openssh = enabled;
      tailscale = enabled;
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "kodicw@gmail.com";
  };
  services.nginx = {
    enable = true;
    virtualHosts."git.declarativepenguin.com" = {
      forceSSL = true;
      enableACME = true;
      extraConfig = ''
        client_max_body_size 512M;
      '';
      locations."/".proxyPass = "http://nadia-forgejo:3000";
    };
  };

  #   enable = true;
  #   staticConfigOptions = {
  #     entryPoints = {
  #       http = {
  #         address = ":80";
  #       };
  #       websecure = {
  #         address = ":443";
  #       };
  #     };
  #   };
  #   dynamicConfigOptions = {
  #     http.routers.git = {
  #       rule = "Host(`git.declarativepenguin.com`)";
  #       service = "forgejo";
  #     };
  #     services.forgejo.loadBalancer = {
  #       servers = [
  #         {
  #           url = "http://nadia-forgejo:3000";
  #         }
  #       ];
  #     };
  #     websecure = {
  #       routers = {
  #         gitsecure = {
  #           rule = "Host(`git.declarativepenguin.com`)";
  #           service = "forgejo";
  #         };
  #       };
  #       services = {
  #         forgejo = {
  #           loadBalancer = {
  #             servers = [
  #               {
  #                 url = "http://nadia-forgejo:3000";
  #               }
  #             ];
  #           };
  #         };
  #       };
  #     };
  #   };
  # };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "24.05";
}
