{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.<app-name>;
  in
  {
  options.${namespace}.apps.<app-name> = with types;
  {
  enable = mkEnableOption "Whether or not to enable <app-name>.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ <app-name> ]; };
  }
