export use template.nu *
export use zellij.nu *
export-env { export use ./env.nu }
export def email [] {
    let from = "noreply@virtualpotato.org";
    let to = input "To? ";
    pop -f $from -t $to
}

export def stabledf [] {
    enter /home/charles/dev/ai/stable-diffusion-webui;
    nix develop .#cuda;
}


export def "edit home" [] {
    enter ~/.config/home-manager
    nu -c $"($env.EDITOR) ~/.config/home-manager/"
}

export def "edit hypr" [] {
    enter ~/.config/hypr
    nu -c $"($env.EDITOR) ~/.config/hypr/"
}

export def "edit ags" [] {
    enter ~/.config/ags
    nu -c $"($env.EDITOR) ~/.config/ags"
}

export def "edit nushell" [] {
    enter ~/.config/nushell/
    nu -c $"($env.EDITOR) ~/.config/nushell"
}

export def "edit snowdev" [] {
    enter ~/dev/code/nix/snowdev
    nu -c $"($env.EDITOR) ~/dev/code/nix/snowdev/"
}

export def "tts" [args] {
    $args | piper -m ~/dev/ai/tts/audio_models/libritts_r/en_US-libritts_r-medium.onnx --output_file tts.wav
    cvlc --play-and-exit tts.wav
    rm tts.wav
}

export def "send sms" [
  message
  --number (-n): string # phone number to send the message to
] {
  kdeconnect-cli -d d4a827b8_6e0f_438b_8d21_c393f02aedd5 --send-sms $message --destination $number
}

export def "send file" [
  fileurl: path
] {
  kdeconnect-cli -d d4a827b8_6e0f_438b_8d21_c393f02aedd5 --share $fileurl
}
