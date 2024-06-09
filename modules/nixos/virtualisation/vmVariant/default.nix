{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.virtualisation.vmVariant;
  lkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.virtualisation.vmVariant = {
    enable = mkEnableOption "Whether or not to enable waybar.";
    memorySize = mkOption {
      type = types.int;
      default = 2048;
      description = "The amount of memory to allocate to the VM.";
    };
    cores = mkOption {
      type = types.int;
      default = 2;
      description = "The number of cores to allocate to the VM.";
    };
    diskSize = mkOption {
      type = types.int;
      default = 20000;
      description = "The size of the disk to allocate to the VM.";
    };

  };

  config = mkIf cfg.enable {
    virtualisation.vmVariant = {
      virtualisation.memorySize = cfg.memorySize;
      virtualisation.cores = cfg.cores;
      virtualisation.diskSize = cfg.diskSize;
    };
  };
}
