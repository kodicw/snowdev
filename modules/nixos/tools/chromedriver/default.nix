{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.chromedriver;
in
{
  options.${namespace}.tools.chromedriver = with types;
    {
      enable = mkEnableOption "Whether or not to enable chromedriver.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ chromedriver ]; };
}
