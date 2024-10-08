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
  cfg = config.${namespace}.bundles.arr;
  services.arr = {
    sonarr = enabled;
    radarr = enabled;
    prowlarr = enabled;
    sabnzbd = enabled;
    users = enabled;
  };
in
{
  options.${namespace}.bundles.arr.enable = mkEnableOption "arr";
  config = mkIf cfg.enable {
    genix = { inherit services; };
  };
}
