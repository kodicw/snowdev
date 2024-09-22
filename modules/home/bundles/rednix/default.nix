{ pkgs
, config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.rednix;
  apps = { };
in
{
  options.${namespace}.bundles.rednix.enable = mkEnableOption "rednix";
  config = mkIf cfg.enable {
    genix = { inherit apps; };
    home.packages = with pkgs; [
      (python311.withPackages (ps: with ps; [
        shodan
      ]))
    ];
  };
}
