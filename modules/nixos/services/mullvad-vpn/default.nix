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
  };
}
