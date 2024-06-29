{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.bundles.gaming;
  apps = {
    steam = enabled;
    armcord = enabled;
    protontricks = enabled;
    bottles = enabled;
  };
in
{
  options.${namespace}.bundles.gaming = {
    enable = mkEnableOption "Whether or not to enable python.";
  };
  config = mkIf cfg.enable {
    genix = { inherit apps; };

    boot.kernel.sysctl = {
      # 20-shed.conf
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      # 20-net-timeout.conf
      # This is required due to some games being unable to reuse their TCP ports
      # if they're killed and restarted quickly - the default timeout is too large.
      "net.ipv4.tcp_fin_timeout" = 5;
      # 30-vm.conf
      # USE MAX_INT - MAPCOUNT_ELF_CORE_MARGIN.
      # see comment in include/linux/mm.h in the kernel tree.
      "vm.max_map_count" = 2147483642;
    };
  };
}
