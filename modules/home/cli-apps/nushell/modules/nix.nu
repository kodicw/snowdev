export def nr [pkg: string] {
    nix run nixpkgs#($pkg)
  }
