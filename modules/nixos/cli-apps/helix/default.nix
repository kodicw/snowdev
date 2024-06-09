{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.helix;
in
{
  options.${namespace}.apps.helix = {
    enable = mkEnableOption "Whether or not to enable helix.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];
  };
}
