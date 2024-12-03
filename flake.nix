{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixvim,
    ...
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

    nixosConfigurations = {
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          home-manager.nixosModules.home-manager
          ./system/hosts/server
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          home-manager.nixosModules.home-manager
          ./system/hosts/thinkpad
        ];
      };
    };

    homeConfigurations = {
      "blakec@server" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homeManager/hosts/server
        ];
      };
      "blakec@thinkpad" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./homeManager/hosts/thinkpad
        ];
      };
    };
  };
}
