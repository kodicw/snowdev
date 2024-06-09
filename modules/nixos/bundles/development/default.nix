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
  cfg = config.${namespace}.bundles.development;
  bundles = {
    common = enabled;
    charm = enabled;
  };
  tools = {
    just = enabled;
    go = enabled;
    cc = enabled;
    javascript = enabled;
    python = enabled;
    rust = enabled;
  };
  cli-apps = { };
in
{
  options.${namespace}.bundles.development.enable = mkEnableOption "Enable Development Bundle";
  config = mkIf cfg.enable {
    genix = { inherit cli-apps tools bundles; };
  };
}
