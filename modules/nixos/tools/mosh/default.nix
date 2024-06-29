{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.mosh;
  in
  {
  options.${namespace}.apps.mosh = with types;
  {
  enable = mkEnableOption "Whether or not to enable mosh.";
  };

  config =
    mkIf cfg.enable { 

      programs.mosh = {
        enable = true;
        openFirewall = true;
      };
    };
  }
