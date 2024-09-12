{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.proton-vpn;
in
{
  options.${namespace}.apps.proton-vpn = with types;
    {
      enable = mkEnableOption "Whether or not to enable protonvpn-gui.";
    };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ protonvpn-gui ]; };
}
