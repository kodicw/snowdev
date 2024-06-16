NixOS Options
────────────────────
# services.mongodb.enable
Whether to enable the MongoDB server.
type: boolean


NixOS Options
────────────────────
# services.mongodb.bind_ip
IP to bind to
type: string


NixOS Options
────────────────────
# services.mongodb.initialScript
A file containing MongoDB statements to execute on first startup.

type: null or path


NixOS Options
────────────────────
# services.mongodb.package
The mongodb package to use.
type: package


NixOS Options
────────────────────
# services.mongodb.dbpath
Location where MongoDB stores its files
type: string


NixOS Options
────────────────────
# services.mongodb.user
User account under which MongoDB runs
type: string


NixOS Options
────────────────────
# services.mongodb.enableAuth
Enable client authentication. Creates a default superuser with username root!
type: boolean


NixOS Options
────────────────────
# services.mongodb.replSetName
If this instance is part of a replica set, set its name here.
Otherwise, leave empty to run as single node.

type: string


NixOS Options
────────────────────
# services.mongodb.pidFile
Location of MongoDB pid file
type: string


NixOS Options
────────────────────
# services.mongodb.quiet
quieter output
type: boolean


NixOS Options
────────────────────
# services.mongodb.initialRootPassword
Password for the root user if auth is enabled.
type: null or string


NixOS Options
────────────────────
# services.mongodb.extraConfig
MongoDB extra configuration in YAML format
type: strings concatenated with "\n"


