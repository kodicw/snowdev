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
        pandas
        pillow
        requests
        flask
        selenium
        sqlalchemy
        ffmpeg-python
        openpyxl
        google-api-python-client
        pyquery
        feedparser
        langchain
        beautifulsoup4
        rich
        shodan
        openai
        python-lsp-server
      ]))
    ];
  };
}
