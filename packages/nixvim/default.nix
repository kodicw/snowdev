{ system, inputs, ... }:
inputs.nixvim.legacyPackages."${system}".makeNixvimWithModule {
  module = import ./config.nix;
}

 

