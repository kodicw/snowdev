{ pkgs, lib, namespace, ... }:
let
  openrgb = "${pkgs.openrgb}/bin/openrgb";
in
pkgs.writers.writeNuBin /* nushell */ "rgbctl" ''
  let colors = {
    black: "000000"
    white: "ffffff"
    red: "ff0000"
    green: "00ff00"
    blue: "0000ff"
    yellow: "ffff00"
    cyan: "00ffff"
    purple: "ff00ff"
    indigo: "4b0082"
    chartreuse: "7fff00"
    orange: "ff7f00"
    brown: "a52a2a"
    pink: "ffc0cb"
    skyblue: "87ceeb"
    magenta: "ff00ff"
    gold: "ffd700"
    navy: "000080"
    banana: "ffe135"
    }

  let devices = (
  ${openrgb} -l
  | split row -r "[1-9]+:"
  | enumerate
  | each { |row|
    if ($row.item | str contains "Keychron" ) {
      null
    } else {
      { id: $row.index, name: $row.item }
    }
  })


  def main [args: string] {
    $colors | items {|color, value|
      if ($args == $color) {
        $devices | par-each { |device| change_color $device.id $value};
        print $"($color) set"
        exit
      }
    }
    if ($args == off) {
      $devices | par-each { |device| off $device.id };
      return null
    } else if ($args == "rainbow") {
      rainbow
    } else {
        echo "Usage: lights <color>"
        $colors | items {|color, value|
        try {
            print $"(ansi $color)($color)(ansi reset)"
            } catch {
            null
            }
          }
        echo "Special: off"
    }
  }

  def change_color [device: int color: string] {
    ${openrgb} -d $device -c $color -b 100;
  }

  def off [device: int] {
    ${openrgb} -d $device -b 0;
  }

  def rainbow [] {
    $colors | items {|color, value|
      $devices | each { |device|
       do { change_color $device.id $value; sleep 500ms;} | complete
      }
    }
  }
''

