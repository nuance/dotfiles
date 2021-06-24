{ pkgs, ... }:
{
  imports = [ ./remote.nix ./secrets/work.nix ];

  programs = with pkgs; [
    git-town
  ];
}
