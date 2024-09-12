let latest_version = (http get https://api.github.com/repos/zen-browser/desktop/releases/latest).tag_name
let base_url = $"https://github.com/zen-browser/desktop/releases/download/($latest_version)"
let files = ["zen.macos-x64.dmg" "zen.macos-aarch64.dmg" "zen.linux-generic.tar.bz2"]

for file in $files {
	let url = $"($base_url)/($file)"
	let my_hash = (nix-prefetch-url --type sha256 $url)
	if $file == "zen.macos-x64.dmg" {
		open default.nix | str replace -r "(x86_64-darwin-hash =).*" $"$1 \"($my_hash)\";" | save -f default.nix
	}
	if $file == "zen.macos-aarch64.dmg" {
		open default.nix | str replace -r "(aarch64-darwin-hash =).*" $"$1 \"($my_hash)\";" | save -f default.nix
	}
	if $file == "zen.linux-generic.tar.bz2" {
		open default.nix | str replace -r "(x86_64-linux-hash =).*" $"$1 \"($my_hash)\";" | save -f default.nix
	}
}
