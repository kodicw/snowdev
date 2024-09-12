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
  cfg = config.${namespace}.desktop.ags-laptop;
  linkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.desktop.ags-laptop = {
    enable = mkEnableOption "Whether or not to enable ags-laptop.";
  };

  config = mkIf cfg.enable {
    home.file.".config/ags".source = linkFile ./ags;
  };
}
