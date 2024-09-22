{ pkgs
, config
, options
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.hyprland;
  cli-apps = {
    ags = enabled;
    gifpaper = enabled;
    wl-clipboard-rs = enabled;
  };
  # services = {
  #   hypridle = enabled;
  # };
in
{
  options.${namespace}.bundles.hyprland.enable = mkEnableOption "hyprland";
  config = mkIf cfg.enable {
    genix = { inherit cli-apps; };
  };
}
