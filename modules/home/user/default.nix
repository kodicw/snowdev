{ lib
, config
, pkgs
, namespace
, osConfig ? { }
, ...
}:
let
  cfg = config.${namespace}.user;
  home-directory =
    if cfg.name == null
    then null
    else "/home/${cfg.name}";
in
with lib;
with lib.${namespace};
{
  options.${namespace}.user = {
    enable = mkEnableOption "Whether to configure the user account.";
    name = mkOption {
      type = (types.nullOr types.str);
      default = (config.snowfallorg.user.name or "charles") "The user account.";
    };

    fullName = mkOption {
      type = types.str;
      default = "Kodi Walls";
      description = "The full name of the user.";
    };
    email = mkOption {
      type = types.str;
      default = "kodicw@gmail.com";
      description = "The email of the user.";
    };

    home = mkOption {
      type = (types.nullOr types.str);
      default = home-directory;
      descrtiption = "The user's home directory.";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "plusultra.user.name must be set";
        }
        {
          assertion = cfg.home != null;
          message = "plusultra.user.home must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.home;
      };
    }
  ]);
}
