let uri = "github:aksiksi/compose2nix"
let script_dir = $env.FILE_PWD


def main [name: string compose: string] {
  let project_dir = $"($script_dir)/modules/nixos/containers/($name)"
  mkdir $project_dir
  let out = $"(project_dir)/default.nix"
  nix run $uri -- -inputs=compose-temp.yml -output=$"($out)" -project=$"($name)"
  }
