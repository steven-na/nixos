{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.homepage-dashboard
    # pkgs.nvidia_smi_exporter
  ];
  services.homepage-dashboard = {
    enable = true;
    listenPort = 8082;
    openFirewall = true;

    # https://gethomepage.dev/latest/configs/settings/
    settings = {};

    # https://gethomepage.dev/latest/configs/bookmarks/
    bookmarks = [
      {
        Developer = [
          {
            Github = [
              {
                abbr = "GH";
                href = "https://github.com/steven-na/";
              }
            ];
          }
        ];
      }
      {
        Entertainment = [
          {
            YouTube = [
              {
                abbr = "YT";
                href = "https://youtube.com/";
              }
            ];
          }
        ];
      }
    ];

    # https://gethomepage.dev/latest/configs/services/
    services = [
      {
        "Portainer" = [
          {
            "link" = {
              description = "";
              href = "https://portainer.stvnc.dev/";
            };
          }
        ];
      }
      {
        "Cockpit" = [
          {
            "link" = {
              description = "";
              href = "http://cockpit.stvnc.dev/";
            };
          }
        ];
      }
    ];

    # https://gethomepage.dev/latest/configs/service-widgets/
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
          memory = true;
        };
      }
    ];

    # https://gethomepage.dev/latest/configs/kubernetes/
    kubernetes = { };

    # https://gethomepage.dev/latest/configs/docker/
    docker = { };

    # https://gethomepage.dev/latest/configs/custom-css-js/
    customJS = "";
    customCSS = "";
  };
}
