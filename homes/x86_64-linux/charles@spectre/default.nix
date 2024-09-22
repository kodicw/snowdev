{ lib
, namespace
, ...
}:
with lib.${namespace}; {
  genix = {
    desktop = {
      hyprland = enabled;
      ags-laptop = enabled;
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
