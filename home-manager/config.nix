{ pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./programs/bash.nix
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/nix.nix
    ./programs/tmux.nix
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
    curl
    tree
    watch
    jq
    eternal-terminal
    go
    gopls
    protobuf
    protoc-gen-go
  ];
}
