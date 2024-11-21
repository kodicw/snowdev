{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.rednix;
in
with lib;
{
  options = {
    ${namespace}.containers.rednix = {
      enable = mkEnableOption "enable rednix container";
    };
  };
  config = lib.mkIf cfg.enable {
    containers."rednix" = {
      extraFlags = [ "-U" ];
      autoStart = true;
      ephemeral = true;
      config = { pkgs, ... }: {
        user.users.rednix = {
          initialHashedPassword = "password";
        };
        environment.systemPackages = with pkgs; [
          (python311.withPackages (ps: with ps; [
            shodan
          ]))
          nmap
          gowitness
          nuclei
          caido
          wpscan
          dirbuster
        ];
        time.timeZone = "America/Los_Angeles";
        system.stateVersion = "24.05";
      };
    };
  };
}
