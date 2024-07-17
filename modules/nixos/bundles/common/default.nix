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
  cfg = config.${namespace}.bundles.common;
  cli-apps = {
    nushell = enabled;
    nixvim = enabled;
  };
  tools = {
    git = enabled;
    mosh = enabled;
  };
  nix = {
    settings = enabled;
    development = enabled;
  };
in
{
  options.${namespace}.bundles.common.enable = mkEnableOption "common";
  config = mkIf cfg.enable {
    genix = { inherit cli-apps tools nix; };
  };
}
