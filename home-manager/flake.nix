{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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
        (import ./overlays/install-apps.nix)
      ];
    in
    {
      homeConfigurations = lib.mapAttrs
        (_: value: inputs.home-manager.lib.homeManagerConfiguration value)
        (importDir ./machines { inherit overlays; });
    };
}
