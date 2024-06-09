{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.kitty;
in
{
  options.${namespace}.cli-apps.kitty = {
    enable = mkEnableOption "Whether or not to enable kitty.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}
