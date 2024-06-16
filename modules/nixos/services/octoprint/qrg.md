NixOS Options
────────────────────
# services.octoprint.port
Port to bind OctoPrint to.

type: 16 bit unsigned integer; between 0 and 65535 (both inclusive)


NixOS Options
────────────────────
# services.octoprint.openFirewall
Open ports in the firewall for OctoPrint.
type: boolean


NixOS Options
────────────────────
# services.octoprint.enable
Whether to enable OctoPrint, web interface for 3D printers.
type: boolean


NixOS Options
────────────────────
# services.octoprint.plugins
Additional plugins to be used. Available plugins are passed through the plugins input.
type: function that evaluates to a(n) list of package


NixOS Options
────────────────────
# services.octoprint.host
Host to bind OctoPrint to.

type: string


NixOS Options
────────────────────
# services.octoprint.stateDir
State directory of the daemon.
type: path


NixOS Options
────────────────────
# services.octoprint.group
Group for the daemon.
type: string


NixOS Options
────────────────────
# services.octoprint.user
User for the daemon.
type: string


NixOS Options
────────────────────
# services.octoprint.extraConfig
Extra options which are added to OctoPrint's YAML configuration file.
type: attribute set


