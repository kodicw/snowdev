{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.tools.iso-net-info;
in
{
  options.${namespace}.tools.iso-net-info = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    programs.bash.interactiveShellInit = ''
      if [[ "$(tty)" =~ /dev/(tty1|hvc0|ttyS0)$ ]]; then
        systemctl restart systemd-vconsole-setup.service
        watch --no-title --color ${pkgs.genix.network_status}/bin/network-status
      fi
    '';
  };
}
