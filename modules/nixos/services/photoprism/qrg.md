NixOS Options
────────────────────
# services.photoprism.package
The photoprism package to use.
type: package


NixOS Options
────────────────────
# services.photoprism.originalsPath
Storage path of your original media files (photos and videos).

type: path


NixOS Options
────────────────────
# services.photoprism.port
Web interface port.

type: 16 bit unsigned integer; between 0 and 65535 (both inclusive)


NixOS Options
────────────────────
# services.photoprism.settings
See [the getting-started guide](https://docs.photoprism.app/getting-started/config-options/) for available options.

type: attribute set of string


NixOS Options
────────────────────
# services.photoprism.storagePath
Location for sidecar, cache, and database files.

type: path


NixOS Options
────────────────────
# services.photoprism.passwordFile
Admin password file.

type: null or path


NixOS Options
────────────────────
# services.photoprism.address
Web interface address.

type: string


NixOS Options
────────────────────
# services.photoprism.importPath
Relative or absolute to the `originalsPath` from where the files should be imported.

type: string


NixOS Options
────────────────────
# services.photoprism.enable
Whether to enable Photoprism web server.
type: boolean


