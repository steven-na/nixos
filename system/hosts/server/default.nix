# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs, config, pkgs, lib, nixvim, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./main-user.nix
      ../../modules/networking
      ../../modules/default
      # ../../modules/nixvim
      ../../modules/homepage
      # ../../modules/jellyseer
      ../../modules/jellyfin
      ../../modules/nvidia
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  main-user = {
    enable = true;
    userName = "blakec";
    description = "Blake C";
  };
  
  programs.zsh.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "blakec" = import ../../../homeManager/hosts/server/default.nix;
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.logind.lidSwitch = "ignore";  
  services.logind.lidSwitchExternalPower = "ignore";

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Put packages here
    unzip
    nftables
    iptables
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  services.openssh = {
	enable = true;
	settings.clientAliveInterval = 60;
  };

  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  services.cockpit = {
    enable = true;
    port = 9090;
    settings = {
      Webservice = {
        AllowUnencrypted = true;
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
