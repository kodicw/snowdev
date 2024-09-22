{ inputs, ... }:
{
  deploy = with inputs;
    {

      sshUser = "root";
      remoteBuild = true;
      nodes =
        {
          node-nadia = {
            hostname = "node-nadia";
            profiles.system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.node-nadia;
            };
          };
          traefik-nixnode = {
            hostname = "traefik-nixnode";
            profiles.system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.traefik-nixnode;
            };
          };
          nadia-forgejo = {
            hostname = "nadia-forgejo";
            profiles.system = {
              user = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nadia-forgejo;
            };
          };
          rpi4 = {
            hostname = "rpi4";
            profiles.system = {
              user = "root";
              path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.rpi4;
            };
          };
        };
    };
}
