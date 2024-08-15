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
    bundles = {
      desktop = enabled;
      cli = enabled;
    };
  };
  home.enableNixpkgsReleaseCheck = false;
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "24.05";
}
