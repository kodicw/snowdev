{ lib
, pkgs
, inputs
, namespace
, home
, target
, format
, virtual
, host
, config
, ...
}:
with lib.${namespace}; {
  genix = {
    desktop = {
      hyprland = enabled;
      ags = enabled;
    };
    bundles = {
      desktop = enabled;
      cli = enabled;
    };
    cli-apps = {
      burpsuite = enabled;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/etc/nixos";
  };
  home.stateVersion = "24.05";
}
