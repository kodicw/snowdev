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
      cli = enabled;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/etc/nixos";
  };
  home.stateVersion = "24.05";
}
