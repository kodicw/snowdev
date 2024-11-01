{ lib
, pkgs
, modulesPath
, namespace
, config
, ...
}:
let
  hostname = "nginx-nixnode";
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
    bundles.development = enabled;
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
      soft-serve = {
        domain = "git.declarativepenguin.com";
        enable = true;
        name = "Daddy's repos";
        ssh_port = ":23231";
      };
      # netbox = enabled;
      terraria = enabled;
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "kodicw@gmail.com";
  };
  environment.systemPackages = with pkgs; [ dotnet-sdk_8 ];
  services.nginx = {
    enable = true;
    virtualHosts = {
      "git.declarativepenguin.com" = {
        forceSSL = true;
        enableACME = true;
        extraConfig = ''
          client_max_body_size 512M;
        '';
        locations."/".proxyPass = "http://localhost:23232";
      };
    };
  };
  # networking.firewall.allowedTCPPorts = [ 80 443 7777 7778];
  networking.firewall.allowedTCPPorts = [  7777 ];
  programs.nix-ld.enable = true;
  networking = {
    hostName = hostname;
  };
  system.stateVersion = "24.05";
}
