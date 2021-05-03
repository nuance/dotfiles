{ overlays, ... }:
{

  system = "x86_64-linux";

  homeDirectory = "/Users/matt";
  username = "matt";

  stateVersion = "21.05";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${../rebuild.sh} dl)";
      imports = [ ../config.nix ];
    };
}
