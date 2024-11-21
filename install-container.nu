let uri = "github:aksiksi/compose2nix"


def main [name: string = "", compose: string = ""] {
  let compose = if ($compose == "") { 
    nix run nixpkgs#gum write 
  } else { $compose }
  let name = if ($name == "") { input "Name of the container" } else { $name }
  let project_dir = $"($env.FILE_PWD)/modules/nixos/containers/($name)"
  mkdir $project_dir
  let out = $"($project_dir)/default.nix"
  # $compose | save "compose-temp.yml"
  nix run $uri -- -inputs=compose-temp.yml -output=$"($out)" -project=$"($name)"
  rm "compose-temp.yml"
}
