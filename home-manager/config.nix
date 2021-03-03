{ pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/bash.nix
    ./programs/git.nix
    ./programs/nix.nix
    ./programs/tmux.nix
  ];

  home.packages = with pkgs; [
    curl
    tree
    watch
    mosh
    pv
    cachix
  ];
}