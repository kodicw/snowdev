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
  cfg = config.${namespace}.desktop.ags;
  linkFile = config.lib.file.mkOutOfStoreSymlink;
in
{
  options.${namespace}.desktop.ags = {
    enable = mkEnableOption "Whether or not to enable ags.";
  };

  config = mkIf cfg.enable {
    home.file.".config/ags".source = linkFile ./ags;
  };
}
