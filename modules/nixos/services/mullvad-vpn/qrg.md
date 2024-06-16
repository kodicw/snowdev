NixOS Options
────────────────────
# services.mullvad-vpn.enableExcludeWrapper
This option activates the wrapper that allows the use of mullvad-exclude.
Might have minor security impact, so consider disabling if you do not use the feature.

type: boolean


NixOS Options
────────────────────
# services.mullvad-vpn.enable
This option enables Mullvad VPN daemon.
This sets {option}`networking.firewall.checkReversePath` to "loose", which might be undesirable for security.

type: boolean


NixOS Options
────────────────────
# services.mullvad-vpn.package
The mullvad package to use. `pkgs.mullvad` only provides the CLI tool, `pkgs.mullvad-vpn` provides both the CLI and the GUI.

type: package


