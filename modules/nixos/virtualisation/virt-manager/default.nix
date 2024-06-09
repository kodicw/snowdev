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
  cfg = config.${namespace}.virtualisation.virt-manager;
  lkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.virtualisation.virt-manager = {
    enable = mkEnableOption "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.virt-manager pkgs.win-virtio ];
    virtualisation.libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
  };
}
