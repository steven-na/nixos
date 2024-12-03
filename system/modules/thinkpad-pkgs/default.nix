{ pkgs, config, ... }:
{
environment.systemPackages = with pkgs; [
    wget
    tree
    nix-prefetch-git
    fastfetch
    home-manager
    git
    gotop
    pass
    lshw
    delta
    file
    unzip
    nftables
    iptables
  ];
}
