{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.bundles.charles;
  networkingTools = with pkgs; [
    nmap
    rustscan
    netcat
    whois
    tcpdump
  ];

  osintTools = with pkgs; [
    instaloader
  ];

  multiMediaPrograms = with pkgs; [
    spotify
    obs-studio
    ytfzf
    mpv
    ani-cli
    pamixer
    ffmpeg
    motion
  ];

  hyprlandApplications = with pkgs; [
    waybar
    dunst
    swww
    grimblast
    swappy
    slurp
    brightnessctl
    networkmanagerapplet
    cliphist
  ];

  cli = with pkgs; [
    tldr
    trash-cli
    circumflex
    typer
    pass
    nerdfonts
  ];

  androidTools = with pkgs; [
    scrcpy
  ];

  utilities = with pkgs; [
    blueman
    rpi-imager
    fzf
    dolphin
    ark
    streamdeck-ui
  ];

  picopython = with pkgs; [
    thonny
    minicom
  ];

  artificialIntelligence = with pkgs; [
    piper-tts
    ollama
  ];

  webBrowser = with pkgs; [
    vivaldi
  ];

in
{
  options.${namespace}.bundles.charles = {
    enable = mkEnableOption "Whether or not to enable charles.";
  };

  config = mkIf cfg.enable
    {
      home.packages =
        networkingTools ++
        webBrowser ++
        artificialIntelligence ++
        osintTools ++
        multiMediaPrograms ++
        hyprlandApplications ++
        picopython ++
        cli ++
        androidTools ++
        utilities;
    };
}
