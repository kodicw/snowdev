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
  cfg = config.${namespace}.bundles.art;
  apps = {
    blender = enabled;
    gimp = enabled;
  };
in
{
  options.${namespace}.bundles.art.enable = mkEnableOption "art";
  config = mkIf cfg.enable {
    genix = { inherit apps; };
  };
}
