{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.fzf;
in
{
  options.${namespace}.cli-apps.fzf = with types;
    {
      enable = mkEnableOption "Whether or not to enable fzf.";
    };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ fzf ]; };
}
