{ pkgs, config, ... }:
{
environment.systemPackages = with pkgs; [
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
    file
  ];
}
