{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/matt";
  username = "matt";

  stateVersion = "21.05";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles && ${../rebuild.sh} macos-bootstrap)";
      imports = [ ../programs/nix.nix ];

      programs.home-manager.enable = true;
    };
}
