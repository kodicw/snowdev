{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.motion;
in
{
  options.${namespace}.cli-apps.motion = with types;
    {
      enable = mkEnableOption "Whether or not to enable motion.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ motion ]; };
}
