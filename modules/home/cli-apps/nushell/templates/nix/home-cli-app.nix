{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.<app-name>;
  in
  {
  options.${namespace}.cli-apps.<app-name> = with types;
  {
  enable = mkEnableOption "Whether or not to enable <app-name>.";
  };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ <app-name> ]; };
  }
