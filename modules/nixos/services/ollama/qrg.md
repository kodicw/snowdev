NixOS Options
────────────────────
# services.ollama.environmentVariables
Set arbitrary environment variables for the ollama service.

Be aware that these are only seen by the ollama server (systemd service),
not normal invocations like `ollama run`.
Since `ollama run` is mostly a shell around the ollama server, this is usually sufficient.

type: attribute set of string


NixOS Options
────────────────────
# services.ollama.listenAddress
The address which the ollama server HTTP interface binds and listens to.

type: string


NixOS Options
────────────────────
# services.ollama.acceleration
What interface to use for hardware acceleration.

- `null`: default behavior
  if `nixpkgs.config.rocmSupport` is enabled, uses `"rocm"`
  if `nixpkgs.config.cudaSupport` is enabled, uses `"cuda"`
  otherwise defaults to `false`
- `false`: disable GPU, only use CPU
- `"rocm"`: supported by most modern AMD GPUs
- `"cuda"`: supported by most modern NVIDIA GPUs

type: null or one of false, "rocm", "cuda"


NixOS Options
────────────────────
# services.ollama.package
The ollama package to use.
type: package


NixOS Options
────────────────────
# services.ollama.models
The directory that the ollama service will read models from and download new models to.

type: string


NixOS Options
────────────────────
# services.ollama.home
The home directory that the ollama service is started in.

type: string


NixOS Options
────────────────────
# services.ollama.enable
Whether to enable ollama server for local large language models.
type: boolean


