{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.quickemu;
in
{
  options.${namespace}.apps.quickemu = {
    enable = mkEnableOption "Whether or not to enable quickemu.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      quickemu
    ];
  };
}
