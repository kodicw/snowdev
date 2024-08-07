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
      exports = mkOption {
        type = types.str;
        default = ''
          /export        100.68.109.59(rw,fsid=0,no_subtree_check) 
          /export/share  100.68.109.59(rw,nohide,insecure,no_subtree_check) 
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    services.nfs.server.enable = true;
    services.nfs.server.exports = cfg.exports;
    fileSystems."/export/share" = {
      device = cfg.device;
      options = [ "bind" ];
    };
    networking.firewall.allowedTCPPorts = [ 2049 ];
  };
}
