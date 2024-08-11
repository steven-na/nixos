{ pkgs, config, ... }: 
{ 
# environment.systemPackages = [ pkgs.cloudflared ];

 # users.users.cloudflared = {
    # group = "cloudflared";
    # isSystemUser = true;
  # };
  # users.groups.cloudflared = { };
  
  
    # systemd.services.my_tunnel = {
    # wantedBy = [ "multi-user.target" ];
    # after = [ "network.target" ];
    # after = [ "network-online.target" "systemd-resolved.service" ];
    # serviceConfig = {
      # ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=eyJhIjoiMjNkODYzNjNmMmFjMzY3NTU5NmI1Zjg2YzQ5MWI2NTAiLCJ0IjoiOTUxMmM4NTUtYjQxZC00ODgzLWFjMTItMTllZTdmZTRlYThjIiwicyI6IlpUZzJNR1ZqT0dNdFkyTmxOaTAwWkRSbExUZzVaVGN0TUdKbU4yTXdOV1pqTVRKbSJ9";
      # ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --credentials-file=/home/prateek/cloudflare.token";
      # Restart = "always";
      # User = "cloudflared";
      # Group = "cloudflared";
    # };
  # };

  networking = {
 
    nftables = {
      enable = true;
      ruleset = ''
          table ip nat {
            chain PREROUTING {
              type nat hook prerouting priority dstnat; policy accept;
              iifname "wlp4s0" tcp dport 25565 dnat to 192.168.1.36:25565
              iifname "wlp4s0" udp dport 25565 dnat to 192.168.1.36:25565
              iifname "wlp4s0" udp dport 24454 dnat to 192.168.1.36:24454
            }
          }
      '';
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        9443 #Portainer
        8080 9090 #Cockpit
        25565 #MC
        8989 7878 8181 7878 8891 #Servarr
        5055 # Jellyseer
      ];
      allowedUDPPorts = [ 
        25565 24454 #MC
        8989 7878 8181 9191 8891 # Servarr
        5055 # Jellyseer
      ];
    };
    nat = {
      enable = true;
      internalInterfaces = [ "wlp4s0" ];
      externalInterface = "wlp4s0";
      forwardPorts = [
        {
          sourcePort = 22;
          proto = "tcp";
          destination = "192.168.1.36:22";
        }
        {
          sourcePort = 25565;
          proto = "tcp";
          destination = "192.168.1.36:25565";
        }
        {
          sourcePort = 25565;
          proto = "udp";
          destination = "192.168.1.36:25565";
        }
        {
          sourcePort = 24454;
          proto = "udp";
          destination = "192.168.1.36:24454";
        }
        {
          sourcePort = 8080;
          proto = "tcp";
          destination = "192.168.1.36:8080";
        }
      ];
    };
  };
}
