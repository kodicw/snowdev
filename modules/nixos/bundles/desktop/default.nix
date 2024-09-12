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
    libreoffice = enabled;
    stacer = enabled;
    spotify = enabled;
    kdenlive = enabled;
    proton-pass = enabled;
    protonmail-desktop = enabled;
  };
  cli-apps = {
    kitty = enabled;
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
