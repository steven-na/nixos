{ inputs, outputs, lib, config, pkgs, ... }:

{
  home.username = "blakec";
  home.homeDirectory = "/home/blakec";

  imports = [
    ../../modules/thinkpad-terminal
  ];
  home.stateVersion = "24.05";
  home.packages = [];

  home.file = {};

  home.sessionVariables = {};

  programs.home-manager.enable = true;
}
