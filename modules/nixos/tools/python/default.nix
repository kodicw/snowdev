{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.python;
in
{
  options.${namespace}.tools.python = {
    enable = mkEnableOption "Whether or not to enable python.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ruff
      (python311.withPackages (ps: with ps; [
        html5lib
        playwright
        # pyinstaller
        pandas
        pexpect
        pillow
        schedule
        requests
        typer
        flask
        selenium
        sqlalchemy
        numpy
        ffmpeg-python
        openpyxl
        google-api-python-client
        pyquery
        fabric
        feedparser
        langchain
        beautifulsoup4
        rich
        openai
        python-lsp-server
      ]))
    ];
  };
}
