export def "nix init" [
	type
	--name (-n): string
] {
    match $type {
        "app"     => {cat ~/.config/nushell/templates/nix/app.nix |  str replace -a "<app-name>" $name},
        "cli-app" => {cat ~/.config/nushell/templates/nix/cli-app.nix |  str replace -a "<app-name>" $name},
        "service" => {cat ~/.config/nushell/templates/nix/service.nix |  str replace -a "<service-name>" $name},
	"home-app" => {cat ~/.config/nushell/templates/nix/home-app.nix |  str replace -a "<app-name>" $name},
	"home-cli-app" => {cat ~/.config/nushell/templates/nix/home-cli-app.nix |  str replace -a "<app-name>" $name},
        }
}
