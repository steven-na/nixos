{ config, pkgs, lib, ... }:

let
  # Fetch the Git repository
  weztermConfig = pkgs.fetchGit {
    url = "https://github.com/steven-na/wezterm-config";
    rev = "main"; # or a specific commit hash
  };
in {
  home.packages = [ pkgs.wezterm ];

  programs.wezterm = {
    enable = true;

    # Use the fetched Git configuration as an extra input
    extraConfig = ''
      dofile("${weztermConfig}/wezterm.lua")
    '';
  };
}
