{ config
, lib
, pkgs
, namespace
, options
, ...
}:
let
  cfg = config.${namespace}.system.boot.grub;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.system.boot.grub.enable = mkEnableOption "Enable GRUB EFI support";
  };
  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "dev/sda";
        useOSProber = true;
        efiSupport = true;
      };
    };
  };
}

