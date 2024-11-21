{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.hyprland-smart;
  linkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.desktop.hyprland-smart = {
    enable = mkEnableOption "Whether or not to enable hyprland.";
  };
  config = mkIf cfg.enable {
    home.file.".config/hypr".source = linkFile ./hypr;
  };
}
