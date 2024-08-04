{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.mullvad-vpn;
in
{
  options.${namespace}.services.mullvad-vpn = with types; {
    enable = mkEnableOption "Whether or not to configure mullvad";
  };

  config = mkIf cfg.enable {
    services.mullvad-vpn.enable = true;
    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "9.9.9.9#nine.nine.nine.nine" "1.0.0.1#one.one.one.one" ];
      dnsovertls = "true";
    };
    networking.nameservers = [ "9.9.9.9#nine.nine.nine.nine" "1.0.0.1#one.one.one.one" ];
    # TCP : 80, 443, 1401
    # UDP : 53, 1194, 1195, 1196, 1197, 1300, 1301, 1302, 1303, 1400
  };
}
