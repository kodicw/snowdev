{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.apps.jellyfin-web;
  in
  {
  options.${namespace}.apps.jellyfin-web = with types;
  {
  enable = mkEnableOption "Whether or not to enable jellyfin-web.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ jellyfin-web ]; };
  }