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
  cfg = config.${namespace}.bundles.desktop;
  apps = {
    vlc = enabled;
    gparted = enabled;
    vivaldi = enabled;
    libreoffice = enabled;
    stacer = enabled;
  };
  cli-apps = {
    kitty = enabled;
    home-manager = enabled;
  };
  desktop = {
    plasma = enabled;
  };
in
{
  options.${namespace}.bundles.desktop = {
    enable = mkEnableOption "Whether or not to enable python.";
  };

  config = mkIf cfg.enable { genix = { inherit apps cli-apps desktop; }; };
}
