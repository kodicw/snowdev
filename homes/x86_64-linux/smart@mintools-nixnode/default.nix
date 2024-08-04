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
    cli-apps = {
      ark = enabled;
      fzf = enabled;
      minicom = enabled;
    };
    apps = { };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    FLAKE = "/etc/nixos";
  };
  programs.nushell =
    {
      enable = true;
      extraConfig = /* nushell */ ''
        $env.config.show_banner = false
      '';
    };
  home.packages = with pkgs;
    [ btop genix.nixvim helix python311 google-chrome ];
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.05";
}

# curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install


