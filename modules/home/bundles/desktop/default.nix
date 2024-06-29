{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.desktop;
  apps = {
    vivaldi = enabled;
    google-chrome = enabled;
    dolphin = enabled;
    rpi-imager = enabled;
    networkmanagerapplet = enabled;
    blueman = enabled;
    streamdeck-ui = enabled;
  };
in
{
  options = {
    ${namespace}.bundles.desktop = {
      enable = mkEnableOption "desktop bundle";
    };
  };
  config = mkIf cfg.enable {
    genix = { inherit apps; };
  };
}
