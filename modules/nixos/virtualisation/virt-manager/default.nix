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
    boot.extraModprobeConfig = "options kvm_intel nested=1";
    security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      win-virtio
      virt-manager
      qemu_kvm
      libguestfs
      virt-manager
    ];

    systemd.services."libvirtd".reloadIfChanged = true; # reload vm configs from //services/*/libvirt/guests.nix
    virtualisation.libvirtd = {
      enable = true;
      onBoot = "start";
      onShutdown = "suspend";
      allowedBridges = [ "br0" ];
      # qemu.ovmf.enable = true;
      # qemu.ovmf.packages = [ pkgs.OVMFFull.fd pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd ];
      qemu.swtpm.enable = true;
      qemu.swtpm.package = pkgs.swtpm;
    };
  };
}
