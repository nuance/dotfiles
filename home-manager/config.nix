{ pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/bash.nix
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/nix.nix
    ./programs/tmux.nix
    ./programs/zsh.nix
  ];

  home.packages = with pkgs; [
    curl
    tree
    watch
    jq
    eternal-terminal
  ];
}
