{ pkgs, lib, namespace, ... }:
let
  skate = "${pkgs.skate}/bin/skate";
in
pkgs.writers.writeNuBin "get-tail-key" ''
  skate get iso-awsome 
''

