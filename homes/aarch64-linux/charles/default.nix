{ lib
, namespace
, ...
}:
with lib.${namespace}; {
  genix = {
    bundles = {
      cli = enabled;
    };
    cli-apps = {
      nushell = enabled;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/etc/nixos";
  };
  home.stateVersion = "24.05";
}
