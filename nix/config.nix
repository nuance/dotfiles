{ pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/bash.nix
    ./programs/emacs.nix
    ./programs/git.nix
    ./programs/tmux.nix
  ];

  programs.go.enable = true;

  home.packages = with pkgs; [
    curl
    tree
    watch
  ];

  home.file = {
    "bin/editor".source = ./files/editor;
  };
}
