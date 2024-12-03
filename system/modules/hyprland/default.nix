{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  environment.systemPackages = with pkgs; [
    waybar
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))
    dunst
    libnotify
    # rofi-wayland
    wofi
    wl-clipboard
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager = {
    enable = true;
    ly.enable = true;
  };

      # Wayland
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
      # Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "blakec";
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
}
