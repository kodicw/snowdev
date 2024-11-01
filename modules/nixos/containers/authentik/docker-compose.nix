# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."authentik-postgresql" = {
    image = "docker.io/library/postgres:12-alpine";
    environment = {
      "ATHENTIK_TAG" = "2023.8.3";
      "AUTHENTIK_EMAIL__FROM" = "auth@example.com";
      "AUTHENTIK_EMAIL__HOST" = "smtp.example.com";
      "AUTHENTIK_EMAIL__PASSWORD" = "a-L0n6-Strong_password_should_go_here";
      "AUTHENTIK_EMAIL__PORT" = "587";
      "AUTHENTIK_EMAIL__TIMEOUT" = "10";
      "AUTHENTIK_EMAIL__USERNAME" = "auth@example.com";
      "AUTHENTIK_EMAIL__USE_SSL" = "false";
      "AUTHENTIK_EMAIL__USE_TLS" = "true";
      "AUTHENTIK_ERROR_REPORTING__ENABLED" = "true";
      "AUTHENTIK_SECRET_KEY" = "someincrediblylongcomplexkeygoeshere";
      "COMPOSE_PORT_HTTP" = "80";
      "COMPOSE_PORT_HTTPS" = "443";
      "PG_PASS" = "aReallyLongStrongPasswordShouldBePutHere";
      "PG_USER" = "authentik";
      "POSTGRES_DB" = "authentik";
      "POSTGRES_PASSWORD" = "aReallyLongStrongPasswordShouldBePutHere";
      "POSTGRES_USER" = "authentik";
    };
    volumes = [
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/database:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=pg_isready -d \${POSTGRES_DB} -U \${POSTGRES_USER}"
      "--health-interval=30s"
      "--health-retries=5"
      "--health-start-period=20s"
      "--health-timeout=5s"
      "--network-alias=postgresql"
      "--network=authentik_default"
    ];
  };
  systemd.services."podman-authentik-postgresql" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-authentik_default.service"
    ];
    requires = [
      "podman-network-authentik_default.service"
    ];
    partOf = [
      "podman-compose-authentik-root.target"
    ];
    wantedBy = [
      "podman-compose-authentik-root.target"
    ];
  };
  virtualisation.oci-containers.containers."authentik-redis" = {
    image = "docker.io/library/redis:alpine";
    volumes = [
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/redis:/data:rw"
    ];
    cmd = [ "--save" "60" "1" "--loglevel" "warning" ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=redis-cli ping | grep PONG"
      "--health-interval=30s"
      "--health-retries=5"
      "--health-start-period=20s"
      "--health-timeout=3s"
      "--network-alias=redis"
      "--network=authentik_default"
    ];
  };
  systemd.services."podman-authentik-redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-authentik_default.service"
    ];
    requires = [
      "podman-network-authentik_default.service"
    ];
    partOf = [
      "podman-compose-authentik-root.target"
    ];
    wantedBy = [
      "podman-compose-authentik-root.target"
    ];
  };
  virtualisation.oci-containers.containers."authentik-server" = {
    image = "ghcr.io/goauthentik/server:2023.8.3";
    environment = {
      "ATHENTIK_TAG" = "2023.8.3";
      "AUTHENTIK_EMAIL__FROM" = "auth@example.com";
      "AUTHENTIK_EMAIL__HOST" = "smtp.example.com";
      "AUTHENTIK_EMAIL__PASSWORD" = "a-L0n6-Strong_password_should_go_here";
      "AUTHENTIK_EMAIL__PORT" = "587";
      "AUTHENTIK_EMAIL__TIMEOUT" = "10";
      "AUTHENTIK_EMAIL__USERNAME" = "auth@example.com";
      "AUTHENTIK_EMAIL__USE_SSL" = "false";
      "AUTHENTIK_EMAIL__USE_TLS" = "true";
      "AUTHENTIK_ERROR_REPORTING__ENABLED" = "true";
      "AUTHENTIK_POSTGRESQL__HOST" = "postgresql";
      "AUTHENTIK_POSTGRESQL__NAME" = "authentik";
      "AUTHENTIK_POSTGRESQL__PASSWORD" = "aReallyLongStrongPasswordShouldBePutHere";
      "AUTHENTIK_POSTGRESQL__USER" = "authentik";
      "AUTHENTIK_REDIS__HOST" = "redis";
      "AUTHENTIK_SECRET_KEY" = "someincrediblylongcomplexkeygoeshere";
      "COMPOSE_PORT_HTTP" = "80";
      "COMPOSE_PORT_HTTPS" = "443";
      "PG_PASS" = "aReallyLongStrongPasswordShouldBePutHere";
      "PG_USER" = "authentik";
    };
    volumes = [
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/custom-templates:/templates:rw"
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/media:/media:rw"
    ];
    ports = [
      "80:9000/tcp"
      "443:9443/tcp"
    ];
    cmd = [ "server" ];
    dependsOn = [
      "authentik-postgresql"
      "authentik-redis"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=server"
      "--network=authentik_default"
    ];
  };
  systemd.services."podman-authentik-server" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-authentik_default.service"
    ];
    requires = [
      "podman-network-authentik_default.service"
    ];
    partOf = [
      "podman-compose-authentik-root.target"
    ];
    wantedBy = [
      "podman-compose-authentik-root.target"
    ];
  };
  virtualisation.oci-containers.containers."authentik-worker" = {
    image = "ghcr.io/goauthentik/server:2023.8.3";
    environment = {
      "ATHENTIK_TAG" = "2023.8.3";
      "AUTHENTIK_EMAIL__FROM" = "auth@example.com";
      "AUTHENTIK_EMAIL__HOST" = "smtp.example.com";
      "AUTHENTIK_EMAIL__PASSWORD" = "a-L0n6-Strong_password_should_go_here";
      "AUTHENTIK_EMAIL__PORT" = "587";
      "AUTHENTIK_EMAIL__TIMEOUT" = "10";
      "AUTHENTIK_EMAIL__USERNAME" = "auth@example.com";
      "AUTHENTIK_EMAIL__USE_SSL" = "false";
      "AUTHENTIK_EMAIL__USE_TLS" = "true";
      "AUTHENTIK_ERROR_REPORTING__ENABLED" = "true";
      "AUTHENTIK_POSTGRESQL__HOST" = "postgresql";
      "AUTHENTIK_POSTGRESQL__NAME" = "authentik";
      "AUTHENTIK_POSTGRESQL__PASSWORD" = "aReallyLongStrongPasswordShouldBePutHere";
      "AUTHENTIK_POSTGRESQL__USER" = "authentik";
      "AUTHENTIK_REDIS__HOST" = "redis";
      "AUTHENTIK_SECRET_KEY" = "someincrediblylongcomplexkeygoeshere";
      "COMPOSE_PORT_HTTP" = "80";
      "COMPOSE_PORT_HTTPS" = "443";
      "PG_PASS" = "aReallyLongStrongPasswordShouldBePutHere";
      "PG_USER" = "authentik";
    };
    volumes = [
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/certs:/certs:rw"
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/custom-templates:/templates:rw"
      "/home/charles/dev/code/nix/snowdev/modules/nixos/containers/authentik/media:/media:rw"
      "/var/run/docker.sock:/var/run/docker.sock:rw"
    ];
    cmd = [ "worker" ];
    dependsOn = [
      "authentik-postgresql"
      "authentik-redis"
    ];
    user = "root";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=worker"
      "--network=authentik_default"
    ];
  };
  systemd.services."podman-authentik-worker" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-authentik_default.service"
    ];
    requires = [
      "podman-network-authentik_default.service"
    ];
    partOf = [
      "podman-compose-authentik-root.target"
    ];
    wantedBy = [
      "podman-compose-authentik-root.target"
    ];
  };

  # Networks
  systemd.services."podman-network-authentik_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f authentik_default";
    };
    script = ''
      podman network inspect authentik_default || podman network create authentik_default
    '';
    partOf = [ "podman-compose-authentik-root.target" ];
    wantedBy = [ "podman-compose-authentik-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-authentik-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
