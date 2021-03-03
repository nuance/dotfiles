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
        (import ./overlays/install-apps.nix)
      ];
    in
    {
      homeConfigurations = {
        m1-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
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

        macos-bootstrap = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/macos-bootstrap.nix
              ];
            };

          system = "x86_64-darwin";

          homeDirectory = "/Users/matt";
          username = "matt";
        };

        github-macos-ci = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/github-macos-ci.nix
              ];
            };

          system = "x86_64-darwin";

          homeDirectory = "/Users/runner";
          username = "runner";
        };

        github-linux-ci = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              nixpkgs.overlays = overlays;
              imports = [
                ./machines/github-linux-ci.nix
              ];
            };

          system = "x86_64-linux";

          homeDirectory = "/home/runner";
          username = "runner";
        };

        air = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
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
      macos-bootstrap = self.homeConfigurations.macos-bootstrap.activationPackage;
      github-macos-ci = self.homeConfigurations.github-macos-ci.activationPackage;
      github-linux-ci = self.homeConfigurations.github-linux-ci.activationPackage;
      air = self.homeConfigurations.air.activationPackage;
      dl = self.homeConfigurations.dl.activationPackage;
    };
}
