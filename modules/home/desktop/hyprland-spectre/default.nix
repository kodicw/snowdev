{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.hyprland-spectre;
  linkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.desktop.hyprland-spectre = {
    enable = mkEnableOption "Whether or not to enable hyprland-spectre.";
  };
  config = mkIf cfg.enable {
    home.file.".config/hypr".source = linkFile ./hypr;
  };
}
