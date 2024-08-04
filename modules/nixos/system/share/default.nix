{ lib, config, namespace, ... }:
let
  cfg = config.${namespace}.system.share;
in
with lib;
{


  options = {
    ${namespace}.system.share = {
      enable = mkEnableOption "Enable share server";
      device = mkOption {
        type = types.str;
        default = "/mnt/wdhdd";
        description = "Device to be shared";
      };
    };
  };
  config = mkIf cfg.enable {
    services.nfs.server.enable = true;
    services.nfs.server.exports = ''
      /export        192.168.1.0/24(rw,fsid=0,no_subtree_check) 
      /export/share  192.168.1.0/24(rw,nohide,insecure,no_subtree_check) 
    '';
    fileSystems."/export/share" = {
      device = cfg.device;
      options = [ "x-systemd.automount" "x-systemd.idle-timeout=600" "noauto" ];
    };
    networking.firewall.allowedTCPPorts = [ 2049 ];
  };
}
