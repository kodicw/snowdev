{ namespace, config, lib, pkgs, ... }:
let
  cfg = config.${namespace}.containers.nagios;
in
with lib;
{
  options = {
    ${namespace}.containers.nagios = {
      enable = mkEnableOption "enable nagios container";
    };
  };
  config = lib.mkIf cfg.enable {
    # sops = {
    #   defaultSopsFormat = "json";
    #   defaultSopsFile = ../../../../secrets/secrets.json;
    #   age.keyFile = /home/charles/.config/sops/age/keys.txt;
    #   secrets.nagiosPassword.owner = "";
    # };
    # users.groups.nagios = {
    #   gid = 999;
    # };
    # users.users.nagios = {
    #    isSystemUser = true;
    #   group = "nagios";
    #   uid = 999;
    # };
    containers."nagios" = {
      # extraFlags = [ "-U" ];
      autoStart = true;
      # bindMounts."/secret/password" = {
      #   hostPath = "${config.sops.secrets.nagiosPassword.path}";
      #   isReadOnly = true;
      # };

      forwardPorts = {
        hostPort = 80;
        containerPort = 5693;
        protocol = "tcp";
      };
      config = { pkgs, ... }: {
        services.nagios = {
          enable = true;
          enableWebInterface = true;
          objectDefs = [
            (pkgs.writeText "nagios.cfg" ''
              define host{
                host_name			nix-cluster
                address				192.168.1.134
                check_command			check-host-alive
                check_interval			5
                retry_interval			1
                max_check_attempts		5
                check_period			24x7
                process_perf_data		0
                retain_nonstatus_information	0
                contact_groups			router-admins
                notification_interval		30
                notification_period		24x7
                notification_options		d,u,r
                }
              define timeperiod{
                timeperiod_name   24x7
                alias			Non-Work Hours
                sunday			00:00-24:00			
                monday			00:00-24:00	
                tuesday			00:00-24:00	
                wednesday			00:00-24:00	
                thursday			00:00-24:00	
                friday			00:00-24:00	
                saturday			00:00-24:00
                }
              define contactgroup{
                contactgroup_name		router-admins
                alias			Novell Administrators
                members			kodi
                }
              define contact{
                contact_name                    kodi
                alias                           John Doe
                host_notifications_enabled		1
                service_notifications_enabled	1
                service_notification_period     24x7
                host_notification_period        24x7
                service_notification_options    w,u,c,r
                host_notification_options       d,u,r
              host_notification_commands  check-host-alive
                service_notification_commands check-host-alive
                email			jdoe@localhost.localdomain
                pager			555-5555@pagergateway.localhost.localdomain
                address1			xxxxx.xyyy@icq.com
                address2			555-555-5555
                can_submit_commands	1
              }
              define command{
                command_name  check-host-alive
                command_line ping -c 3 $HOSTADDRESS$
                }
                define service{
                  host_name		nix-cluster
                  service_description	check-disk-sda1
                  check_command  check-host-alive	
                  max_check_attempts	5
                  check_interval	5
                  retry_interval	3
                  check_period		24x7
                  notification_interval	30
                  notification_period	24x7
                  notification_options	w,c,r
                  contact_groups		router-admins
                  }
            '')
          ];
        };
        time.timeZone = "America/Los_Angeles";
        networking.firewall.allowedTCPPorts = [ 80 ];
        system.stateVersion = "24.05";
      };
    };
  };
}
