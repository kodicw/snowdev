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
  cfg = config.${namespace}.bundles.jelly;
  services = {
    jellyfin = enabled;
    jellyseerr = enabled;
  };
in
{
  options.${namespace}.bundles.jelly.enable = mkEnableOption "arr";
  config = mkIf cfg.enable {
    genix = { inherit services; };
  };
}
