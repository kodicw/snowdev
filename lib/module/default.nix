{ lib, ... }:
with lib;
{
  enabled = {
    enable = true;
  };
  disabled = {
    enable = false;
  };
  nxHost = hostname: {
    virtualHosts.${hostname} = {
      forceSSL = true;
      enableACME = true;
    };
  };
}

