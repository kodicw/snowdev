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
  exploitationTools = with pkgs; [
    metasploit
    aircrack-ng
    burpsuite
    hackrf
    exploitdb
    iw
  ];

  networkingTools = with pkgs; [
    nmap
    rustscan
    netcat
    wireshark
    bettercap
    whois
    tcpdump
  ];

  osintTools = with pkgs; [
    instaloader
  ];

  charmingTools = with pkgs; [
    charm
    wishlist
    glow
    mods
    pop
    skate
    gum
  ];


  multiMediaPrograms = with pkgs; [
    spotify
    obs-studio
    ytfzf
    mpv
    ani-cli
    pamixer
    vlc
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
        exploitationTools ++
        networkingTools ++
        webBrowser ++
        artificialIntelligence ++
        charmingTools ++
        osintTools ++
        multiMediaPrograms ++
        hyprlandApplications ++
        picopython ++
        cli ++
        androidTools ++
        utilities;
    };
}
