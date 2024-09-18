{ channels, ... }: final: prev: {
  inherit (channels.unstable) forgejo-cli;
}
