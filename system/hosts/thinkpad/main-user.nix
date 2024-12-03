{ lib, config, pkgs, ... }:

let 
  cfg = config.main-user;
in
{
  options = {
    main-user = {
      enable = lib.mkEnableOption "Enable user module";
      userName = lib.mkOption {
        default = "defaultuser";
        description = "username";
      };
      description = lib.mkOption {
        default = "defaultdescription";
        description = "description";
      };    
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "1234";
      description = cfg.description;
      extraGroups = [ "networkmanager" "wheel" "docker"];
      packages = with pkgs; [];
      shell = pkgs.zsh;
    };
  };
}
