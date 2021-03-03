{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-20.09";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.dl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./machines/dl/configuration.nix ];
    };
  };
}
