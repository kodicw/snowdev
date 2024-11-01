{ channels, ... }: final: prev: {
  inherit (channels.unstable) terraria-server;
}
