{ pkgs, config, ... }:
{
  services.jellyseerr = {
    enable = true;
    openFirewall = true; # 5055
  };
  users.groups.multimedia = {};

  users.users.multimedia = {
    isSystemUser = true;
    group = "multimedia";
    home = "/var/lib/multimedia";
    createHome = true;
  };
}
