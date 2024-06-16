NixOS Options
────────────────────
# services.adguardhome.settings.bind_host
Host address to bind HTTP server to.

type: string


NixOS Options
────────────────────
# services.adguardhome.allowDHCP
Allows AdGuard Home to open raw sockets (`CAP_NET_RAW`), which is
required for the integrated DHCP server.

The default enables this conditionally if the declarative configuration
enables the integrated DHCP server. Manually setting this option is only
required for non-declarative setups.

type: boolean


NixOS Options
────────────────────
# services.adguardhome.settings.schema_version
Schema version for the configuration.
Defaults to the `schema_version` supplied by `pkgs.adguardhome`.

type: signed integer


NixOS Options
────────────────────
# services.adguardhome.settings
AdGuard Home configuration. Refer to
<https://github.com/AdguardTeam/AdGuardHome/wiki/Configuration#configuration-file>
for details on supported values.

::: {.note}
On start and if {option}`mutableSettings` is `true`,
these options are merged into the configuration file on start, taking
precedence over configuration changes made on the web interface.

Set this to `null` (default) for a non-declarative configuration without any
Nix-supplied values.
Declarative configurations are supplied with a default `schema_version`, `bind_host`, and `bind_port`.
:::

type: null or (YAML value)


NixOS Options
────────────────────
# services.adguardhome.settings.bind_port
Port to serve HTTP pages on.

type: 16 bit unsigned integer; between 0 and 65535 (both inclusive)


NixOS Options
────────────────────
# services.adguardhome.enable
Whether to enable AdGuard Home network-wide ad blocker.
type: boolean


NixOS Options
────────────────────
# services.adguardhome.extraArgs
Extra command line parameters to be passed to the adguardhome binary.

type: list of string


NixOS Options
────────────────────
# services.adguardhome.mutableSettings
Allow changes made on the AdGuard Home web interface to persist between
service restarts.

type: boolean


NixOS Options
────────────────────
# services.adguardhome.openFirewall
Open ports in the firewall for the AdGuard Home web interface. Does not
open the port needed to access the DNS resolver.

type: boolean


