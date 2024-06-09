{ config, pkgs, lib, namespace, ... }:
let
  cfg = config.${namespace}.services.homepage;
in
with lib;
{
  options = {
    ${namespace}.services.homepage.enable = mkEnableOption "Enable the homepage dashboard";
  };

  config = mkIf cfg.enable {
    services.homepage-dashboard = {
      enable = true;
      settings = {
        title = "Homepage";
        favicon = "https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg";
        background = "https://images.pling.com/img/00/00/56/26/59/1442451/4a509e8123f82231c49adaa0a47c8b530709435087fc2e64f87e6a5d22c614b45357.png";
        theme = "dark";
      };
      widgets = [
        {
          resources = {
            cpu = true;
            memory = true;
            disk = "/";
          };
        }
        {
          search = {
            provider = "google";
            target = "_blank";
          };
        }
      ];
      services =
        [
          {
            "Node-Nadia" = [
              {
                Adguard = {
                  icon = "adguard-home.png";
                  href = "http://node-nadia:8000";
                  description = "Adguard Home";
                };
              }
              {
                Octoprint = {
                  icon = "octoprint.png";
                  href = "http://node-nadia:8383";
                  description = "Octoprint";
                };
              }
              {
                Kitchenowl = {
                  icon = "kitchenowl.png";
                  href = "http://kitchen";
                  description = "Kitchenowl";
                };
              }
            ];
          }
        ];
      bookmarks =
        [
          {
            Development = [
              {
                NixOS = [
                  {
                    icon = "https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg";
                    abbr = "NX";
                    href = "https://nixos.org";
                  }
                ];
              }
              {
                GitHub = [
                  {
                    icon = "github.png";
                    abbr = "GH";
                    href = "https://github.com";
                  }
                ];
              }
            ];
          }
          {
            Entertainment = [
              {
                YouTube = [
                  {
                    icon = "https://www.youtube.com/s/desktop/9660ea89/img/favicon.ico";
                    abbr = "YT";
                    href = "https://youtube.com";
                  }
                ];
              }
              {
                Reddit = [
                  {
                    icon = "https://www.redditstatic.com/shreddit/assets/favicon/64x64.png";
                    abbr = "RD";
                    href = "https://reddit.com";
                  }
                ];
              }
              {
                Cruchyroll = [
                  {
                    icon = "https://www.crunchyroll.com/build/assets/img/favicons/favicon-16x16.png";
                    abbr = "CR";
                    href = "https://www.crunchyroll.com";
                  }
                ];
              }
            ];
          }
        ];
    };
  };
}

