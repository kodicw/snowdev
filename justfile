
flake-init template:
    nix flake init --template templates#{{template}}
check:
    git add *
    nix flake check
vm: check
    nixos-rebuild build-vm --impure --flake .#mainframe

