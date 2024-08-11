{ pkgs, config, ... }:
{
environment.systemPackages = with pkgs; [
    vim
    wget
    tree
    nix-prefetch-git
    fastfetch
    cockpit
    home-manager
    git
    gotop
    pass
    lshw
    delta
  ];
}
