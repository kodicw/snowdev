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
  cfg = config.${namespace}.virtualisation.docker;
  lkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.virtualisation.docker = {
    enable = mkEnableOption "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [
      lazydocker
      docker
    ];
  };
}
