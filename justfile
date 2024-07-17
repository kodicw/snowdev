
flake-init template:
    nix flake init --template templates#{{template}}
check:
    git add *
    nix flake check
vm: check
    nixos-rebuild build-vm --impure --flake .#mainframe
send:
  just check
  git commit -am "send it!🌋"
  git push


ssh-sops:
  nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
  
sops:
  nix run nixpkgs#sops secrets.yaml


