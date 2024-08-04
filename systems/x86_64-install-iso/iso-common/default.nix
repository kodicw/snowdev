{ lib
, pkgs
, modulesPath
, namespace
, inputs
, ...
}:
with lib;
with lib.${namespace};
{
  genix = {
    user = {
      charles = enabled;
      root = enabled;
      smart = enabled;
    };
    desktop = {
      gnome = {
        enable = true;
        excludePackages = (with pkgs; [
          gnome-photos
          gnome-tour
          gedit # text editor
        ]) ++ (with pkgs.gnome; [
          cheese # webcam tool
          gnome-music
          epiphany # web browser
          geary # email reader
          evince # document viewer
          gnome-characters
          totem # video player
          tali # poker game
          iagno # go game
          hitori # sudoku game
          atomix # puzzle game
        ]);
      };
    };
    system = {
      locale = enabled;
      fonts = enabled;
      time = enabled;
      xkb = enabled;
    };
    bundles = {
      common = enabled;
      development = enabled;
    };
    nix = {
      settings = enabled;
      development = enabled;
    };
    services = {
      openssh = enabled;
      xrdp = enabled;
    };
    apps = {
      gparted = enabled;
      vivaldi = enabled;
    };
    tools = {
      iso-net-info = enabled;
    };
    virtualisation = {
      docker = enabled;
      virt-manager = enabled;
      vmVariant = enabled;
    };
  };
  networking = {
    hostName = "iso-common";
    networkmanager.enable = mkForce false;
  };
}
