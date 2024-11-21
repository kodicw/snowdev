{ config
, lib
, namespace
, ...
}:

let
  cfg = config.${namespace}.bundles.desktop;
  apps = with lib.${namespace}; {
    vlc = enabled;
    localsend = enabled;
    hacksaw = enabled;
    shotgun = enabled;
    gparted = enabled;
    libreoffice = enabled;
    stacer = enabled;
    spotify = enabled;
    kdenlive = enabled;
    proton-pass = enabled;
    protonmail-desktop = enabled;
    nautilus = enabled;
    banana-cursor = enabled;
  };
  cli-apps = with lib.${namespace}; {
    kitty = enabled;
  };
in
{
  options.${namespace}.bundles.desktop = {
    enable = lib.mkEnableOption "Whether or not to enable python.";
  };
  config = lib.mkIf cfg.enable { genix = { inherit apps cli-apps; }; };
}
