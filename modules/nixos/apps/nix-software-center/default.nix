{ options
, config
, lib
, pkgs
, namespace
, system
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.nix-software-center;
in
{
  options.${namespace}.apps.nix-software-center = {
    enable = mkEnableOption "Whether or not to enable support for OBS.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      nix-software-center.packages.${system}.nix-software-center
    ];
  };
}
