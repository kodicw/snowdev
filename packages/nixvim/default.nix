{ config
, lib
, pkgs
, namespace
, system
, inputs
, ...
}:
inputs.nixvim.legacyPackages."${pkgs.system}".makeNixvimWithModule {
  inherit pkgs;
  module = import ./conf.nix;
}

 

