{ pkgs, lib, namespace, ... }:
let
  gum = "${pkgs.gum}/bin/gum";
in
pkgs.writers.writeNuBin "network_status" ''
    mut msgs = []
  if ("/var/shared/qrcode.utf8" | path exists) {
    let qrcode = ${gum}.style --border-foreground 240 --border normal (path.readText)
    $msgs = ($msgs | append $qrcode)
  }
  mut network_status = (
    "Root password: " + /var/shared/root-password + "\n" + "Local network addresses:\n" + (ip -brief -color addr | grep -v 127.0.0.1)
    )
  $network_status = (${gum} style --border-foreground 240 --border normal $network_status)
  $msgs = ($msgs | append $network_status)
  $msgs = ($msgs | append "Pr ess 'Ctrl-C' for console access")
  print $msgs.0
''

