NixOS Options
────────────────────
# services.xrdp.openFirewall
Whether to open the firewall for the specified RDP port.
type: boolean


NixOS Options
────────────────────
# services.xrdp.defaultWindowManager
The script to run when user log in, usually a window manager, e.g. "icewm", "xfce4-session"
This is per-user overridable, if file ~/startwm.sh exists it will be used instead.

type: string


NixOS Options
────────────────────
# services.xrdp.extraConfDirCommands
Extra commands to run on the default confDir derivation.

type: string


NixOS Options
────────────────────
# services.xrdp.sslKey
ssl private key path
A self-signed certificate will be generated if file not exists.

type: string


NixOS Options
────────────────────
# services.xrdp.package
The xrdp package to use.
type: package


NixOS Options
────────────────────
# services.xrdp.audio.package
The pulseaudio-module-xrdp package to use.
type: package


NixOS Options
────────────────────
# services.xrdp.sslCert
ssl certificate path
A self-signed certificate will be generated if file not exists.

type: string


NixOS Options
────────────────────
# services.xrdp.enable
Whether to enable xrdp, the Remote Desktop Protocol server.
type: boolean


NixOS Options
────────────────────
# services.xrdp.port
Specifies on which port the xrdp daemon listens.

type: 16 bit unsigned integer; between 0 and 65535 (both inclusive)


NixOS Options
────────────────────
# services.xrdp.audio.enable
Whether to enable audio support for xrdp sessions. So far it only works with PulseAudio sessions on the server side. No PipeWire support yet.
type: boolean


