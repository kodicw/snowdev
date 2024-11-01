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
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.banana-cursor;
    size = 96;
    name = "Banana"; # Change to whatever theme you like
  };
  programs.wezterm = {
    enable = true;
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
}
