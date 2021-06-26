{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/matt";
  username = "matt";

  stateVersion = "21.05";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;

      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles && ${../rebuild.sh} m1-pro)";
      programs.zsh.shellAliases.flake-rebuild = "(cd ~/dotfiles && ${../rebuild.sh} m1-pro)";

      imports = [
        ../config.nix
        ../environments/macos.nix
        ../environments/terminal.nix
        ../environments/macos-launch-agents.nix
        ../programs/emacs-server.nix
        ../programs/secretive.nix
      ];
    };
}
