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
  cfg = config.${namespace}.desktop.waybar;
  linkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.desktop.waybar = {
    enable = mkEnableOption "Whether or not to enable waybar.";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };
    home.file.".config/waybar".source = linkFile ./waybar;
  };
}
