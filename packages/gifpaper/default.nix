{ pkgs, lib, namespace, ... }:
let
  openrgb = "${pkgs.openrgb}/bin/openrgb";
in
pkgs.writers.writeNuBin /* nushell */ "gifpaper" ''
   #!/usr/bin/env nu
  # select or set random wallpaper
  def main [
    option: string # random or select
  ] {
    match $option {
      "random" => random_wallpaper,
      "select" => wallpaper_select
    }
  }

  def random_wallpaper [] {
    enter ~/wallpapers/
    let r = (random int ..(ls | length))
    let paper = ((ls | select $r).name | to text)
    # swww clear 000000
    swww img --transition-type outer --transition-pos 0.854,0.977 --transition-step 190 $paper
  }
  # rofi select
  #
  def wallpaper_select [] {
    let wallpaper_dir = ("~/wallpapers" | path expand)
    let choice = (^ls $wallpaper_dir | wofi -dmenu -theme /home/charles/.config/rofi/launchers/type-2/style-1.rasi)
    swww img $"($wallpaper_dir)/($choice)"
  }
 
''
