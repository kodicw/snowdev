{ config
, lib
, pkgs
, namespace
, system
, inputs
, channels
, ...
}:
inputs.nixvim.legacyPackages."${system}".makeNixvimWithModule {
  module = import ./config.nix;
}

 

