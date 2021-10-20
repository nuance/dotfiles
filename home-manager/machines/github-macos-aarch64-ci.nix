{ overlays, ... }:
{

  system = "aarch64-darwin";

  homeDirectory = "/Users/runner";
  username = "runner";

  stateVersion = "21.05";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles && ${../rebuild.sh} github-macos-ci)";
      imports = [ ../config.nix ../environments/macos.nix ];
    };
}
