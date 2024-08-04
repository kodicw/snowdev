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

  mountDrive = { location, device }: {
    ${location} = {
      device = "${device}";
      fsType = "ext4";
      options = [ "user" "nofail" "exec" "async" "auto" "dev" "suid" ];
    };
  };
}

