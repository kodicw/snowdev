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
  cfg = config.${namespace}.bundles.charm;
  cli-apps = {
    charm_sh = {
      glow = enabled;
      charm = enabled;
      wishlist = enabled;
      pop = enabled;
      mods = enabled;
      skate = enabled;
    };
  };
in
{
  options.${namespace}.bundles.charm.enable = mkEnableOption "Enable charm apps";
  config = mkIf cfg.enable {
    genix = { inherit cli-apps; };
  };
}
