{ options
, config
, pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.time;
in
{
  options.${namespace}.system.time = {
    enable =
      mkEnableOption "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable { time.timeZone = "America/Los_Angeles"; };
}
