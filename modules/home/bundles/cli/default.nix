{ config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.cli;
  cli-apps = {
    ani-cli = enabled;
    ark = enabled;
    brightnessctl = enabled;
    cliphist = enabled;
    ffmpeg = enabled;
    fzf = enabled;
    grimblast = enabled;
    minicom = enabled;
    motion = enabled;
    mpv = enabled;
    pamixer = enabled;
    piper-tts = enabled;
    pass = enabled;
    slurp = enabled;
    swappy = enabled;
    swww = enabled;
    tldr = enabled;
    trash-cli = enabled;
    typer = enabled;
    ytfzf = enabled;
  };
in
{
  options = {
    ${namespace}.bundles.cli = {
      enable = mkEnableOption "cli bundle";
    };
  };
  config = mkIf cfg.enable {
    genix = { inherit cli-apps; };
  };
}
