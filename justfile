
flake-init template:
    nix flake init --template templates#{{template}}
add:
    git add *
check: add
    nix flake check --impure
vm MACHINE: add
    nixos-rebuild build-vm --flake .#{{MACHINE}} --impure 
rebuild: add
   sudo nixos-rebuild switch --flake .# --impure
deploy MACHINE HOST:
    deploe --hostname {{HOST}} .#{{MACHINE}} -- --impure
send: check
    git commit -am "send it!🌋"
    git push
ssh-to-sops:
    nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
sops:
    nix run nixpkgs#sops secrets/secrets.yaml


