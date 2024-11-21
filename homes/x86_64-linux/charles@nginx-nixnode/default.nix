{ lib
, namespace
, ...
}:
with lib.${namespace}; {
  genix = {
    cli-apps = {
      nushell = enabled;
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
}
