{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.mastodon;
in
{
  options.${namespace}.services.mastodon = with types;
    {
      enable = mkEnableOption "Whether or not to configure mastodon";
    };

  config = mkIf cfg.enable {
    services.mastodon = {
      enable = true;
      streamingProcesses = 3;
    };
  };
}
