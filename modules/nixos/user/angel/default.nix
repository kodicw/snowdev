{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.user.angel;
in
with lib;
{
  options = {
    ${namespace}.user.angel.enable = mkEnableOption "Enable angel's user configuration";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        angel = {
          isNormalUser = true;
          description = "angel";
          packages = with pkgs; [
            google-chrome
          ];
        };
      };
    };
  };
}
