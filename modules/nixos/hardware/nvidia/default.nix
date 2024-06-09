{ config
, pkgs
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.hardware.nvidia;
in
{
  options = {
    ${namespace}.hardware.nvidia.enable = lib.mkEnableOption "Enable Nvidia drivers";
  };
  config = lib.mkIf cfg.enable {
    # Nvidia GPU drivers
    environment.systemPackages = with pkgs; [
      gwe
    ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      # powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}

