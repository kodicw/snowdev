latest_version=$(curl -s https://api.github.com/repos/zen-browser/desktop/releases/latest | jq -r '.tag_name')
base_url="https://github.com/zen-browser/desktop/releases/download/${latest_version}"
files=("zen.macos-x64.dmg" "zen.macos-aarch64.dmg" "zen.linux-generic.tar.bz2")

echo 'Updating version in zen.nix'
sed -Ei "s/myZenVersion = \"(.*)\"/myZenVersion = \"${latest_version}\"/g" zen.nix

for file in "${files[@]}"
do
  url="${base_url}/${file}"
  echo "Updating hash for ${url}"
  myHash=$(nix-prefetch-url --type sha256 ${url})
  # Update x86_64 MacOS version
  [[ "$file" == "zen.macos-x64.dmg" ]] && sed -Ei "s/x86_64-darwin-hash = \"(.*)\"/x86_64-darwin-hash = \"${myHash}\"/g" zen.nix
  # Update aarch64 MacOS version
  [[ "$file" == "zen.macos-aarch64.dmg" ]] && sed -Ei "s/aarch64-darwin-hash = \"(.*)\"/aarch64-darwin-hash = \"${myHash}\"/g" zen.nix
  # Update x86_64 Linux version
  [[ "$file" == "zen.linux-generic.tar.bz2" ]] && sed -Ei "s/x86_64-linux-hash = \"(.*)\"/x86_64-linux-hash = \"${myHash}\"/g" zen.nix
done
