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
    apps = {
      jami = enabled;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/etc/nixos";
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
}
