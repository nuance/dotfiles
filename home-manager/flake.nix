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
      overlays = [
        inputs.emacs-overlay.overlay
      ];
    in
    {
      homeConfigurations = {
        m1-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              xdg.configFile."nix/nix.conf".text = ''experimental-features = nix-command flakes'';
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/m1-pro.nix
              ];

              programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${./rebuild.sh} m1-pro)";
            };

          system = "x86_64-darwin";

          homeDirectory = "/Users/matt";
          username = "matt";
        };

        air = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              xdg.configFile."nix/nix.conf".text = ''experimental-features = nix-command flakes'';
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/air.nix
              ];

              programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${./rebuild.sh} air)";
            };

          system = "x86_64-darwin";

          homeDirectory = "/Users/matt";
          username = "matt";
        };

        dl = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              xdg.configFile."nix/nix.conf".text = ''experimental-features = nix-command flakes'';
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/dl.nix
              ];

              programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${./rebuild.sh} dl)";
            };

          system = "x86_64-linux";

          homeDirectory = "/home/matt";
          username = "matt";
        };

      };

      m1-pro = self.homeConfigurations.m1-pro.activationPackage;
      air = self.homeConfigurations.air.activationPackage;
      dl = self.homeConfigurations.dl.activationPackage;
    };
}
