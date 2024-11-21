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
    user.root.enable = true;
    desktop = {
      hyprland = enabled;
      ags = enabled;
    };
    bundles = {
      desktop = enabled;
      cli = enabled;
    };
    cli-apps = {
      nushell = {
        enable = true;
      };
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.banana-cursor;
    size = 96;
    name = "Banana"; # Change to whatever theme you like
  };
  dconf.settings = {
      "org/gnome/desktop/background" = {
        picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
}
