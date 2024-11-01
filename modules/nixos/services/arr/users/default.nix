{ lib
, pkgs
, config
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.arr.users;
in
{
  options.${namespace}.services.arr.users = with types;
    {
      enable = mkEnableOption "Whether or not to configure users";
    };

  config = mkIf cfg.enable {
    users.users = {
      arr = {
        isSystemUser = true;
        group = "arr";
        uid = 6969;
      };
    };
    users.groups = {
      arr = {
        gid = 6969;
        members = [ "arr" ];
      };
    };
  };
}

