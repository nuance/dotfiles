{
  description = "home-manager and nixos configurations";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/staging-21.11";

  inputs.emacs-overlay = {
    url = "github:nix-community/emacs-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;
      importDir = dir: attrs: lib.mapAttrs' (name: _: lib.nameValuePair (lib.removeSuffix ".nix" name) (import (dir + "/${name}") attrs))
        (lib.filterAttrs (name: _: lib.hasSuffix ".nix" name)
          (builtins.readDir dir));
      overlays = [
        inputs.emacs-overlay.overlay
        (import ./home-manager/overlays/install-apps.nix)
      ];
    in
    {
      homeConfigurations = lib.mapAttrs
        (_: value: inputs.home-manager.lib.homeManagerConfiguration value)
        (importDir ./home-manager/machines { inherit overlays; });

      nixosConfigurations.dl = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./nixos/machines/dl/configuration.nix { inherit overlays; })
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.matt = import ./home-manager/nixos-machines/remote.nix;
          }
        ];
      };

      nixosConfigurations.vpn = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./nixos/machines/vpn/configuration.nix { inherit overlays; })
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.matt = import ./home-manager/nixos-machines/remote.nix;
          }
        ];
      };
    };
}
