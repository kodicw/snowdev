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
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        http = {
          address = ":80";
        };
        websecure = {
          address = ":443";
        };
      };
    };
    dynamicConfigOptions = {
      http = {
        routers = {
          router1 = {
            rule = "Host(`git.declarativepenguin.com`)";
            service = "forgejo";
          };
        };
        services = {
          forgejo = {
            loadBalancer = {
              servers = [
                {
                  url = "http://nadia-forgejo:3000";
                }
              ];
            };
          };
        };
      };
      websecure = {
        routers = {
          router1 = {
            rule = "Host(`git.declarativepenguin.com`)";
            service = "forgejo";
          };
        };
        services = {
          forgejo = {
            loadBalancer = {
              servers = [
                {
                  url = "http://nadia-forgejo:3000";
                }
              ];
            };
          };
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "24.05";
}
