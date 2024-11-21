{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.cli-apps.nushell;
in
{
  options.${namespace}.cli-apps.nushell = with types;
    {
      enable = mkEnableOption "Whether or not to enable nushell.";
      skate = mkEnableOption "Whether or not to enable skate integration";
    };

  config =
    mkIf cfg.enable {
      home.packages = with pkgs; [
        nushell
        # nushellPlugins.gstat
        # nushellPlugins.net
        # nushellPlugins.query
        # nushellPlugins.formats
      ];
      home.file.".config/nushell/modules".source = ./modules;
      home.file.".config/nushell/templates".source = ./templates;
      programs = {
        zellij = {
          enable = true;
          settings = {
            simplified_ui = true;
            default_shell = "nu";
            pane_frames = false;
          };
        };
        carapace = {
          enable = true;
          enableNushellIntegration = true;
        };
        nushell = {
          enable = true;
          configFile.source = ./config.nu;
          envFile.source = ./env.nu;
          shellAliases = {
            "cd" = "z";
          };
          extraEnv =
            let
              skate = "${pkgs.skate}/bin/skate";
            in
            mkIf cfg.skate
              ''
                $env.CHARM_HOST = "mainframe"
                $env.RESEND_API_KEY = (${skate} get resend_api_key)
                $env.OPENAI_API_KEY = (${skate} get openai_api_key)
                $env.POP_SMTP_USERNAME = (${skate} get email)
                $env.POP_SMTP_PASSWORD = (${skate} get email_password)
                $env.ANTHROPIC_API_KEY = (${skate} get anthropic_api_key)        
              '';

        };
        zoxide = {
          enable = true;
          enableNushellIntegration = true;
        };
        atuin = {
          enable = true;
          enableNushellIntegration = true;
        };
        starship = {
          enable = true;
          settings = {
            format = ''
              [╭╴](2388)$os$username$hostname$directory$git_branch$git_status$git_commit$rust$python$dotnet$kotlin$java$all $battery
              [╰─](238)$character '';
            add_newline = true;
            # character = {
            #   success_symbol = "[➜](bold green)";
            #   error_symbol = "[➜](bold red)";
            # };
          };
        };
      };
    };
}
