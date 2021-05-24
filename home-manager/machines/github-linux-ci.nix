{ overlays, ... }:
{

  system = "x86_64-linux";

  homeDirectory = "/home/runner";
  username = "runner";

  stateVersion = "21.05";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles && ${../rebuild.sh} github-linux-ci)";
      imports = [ ../config.nix ../programs/emacs.nix ];
    };
}
