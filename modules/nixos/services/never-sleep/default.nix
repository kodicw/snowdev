{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.services.neverSleep;
in
{
  options = {
    ${namespace}.services.neverSleep.enable = lib.mkEnableOption "Enable never sleep";
  };
  config = lib.mkIf cfg.enable {
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
  };
}
