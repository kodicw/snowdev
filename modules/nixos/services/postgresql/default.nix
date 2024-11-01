{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.postgresql;
in
{
  options.${namespace}.services.postgresql = with types;
    {
      enable = mkEnableOption "Whether or not to configure postgresql";
      password = mkOption {
        type = str;
        default = "nixcloud";
        description = "The password for the postgres";
      };
    };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 5432 ];
    services.postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" ];
      enableTCPIP = true;
      settings.port = 5432;
      # settings = {
      #   ssl = true;
      # };
      # authentication = pkgs.lib.mkOverride 10 ''
      #   #...
      #   #type database DBuser origin-address auth-method
      #   # ipv4
      #   host  all      all     127.0.0.1/32   trust
      #   # ipv6
      #   host all       all     ::1/128        trust
      # '';
      # initialScript = pkgs.writeText "backend-initScript" ''
      #   CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      #   CREATE DATABASE nixcloud;
      #   GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
      # '';
    };
  };
}
