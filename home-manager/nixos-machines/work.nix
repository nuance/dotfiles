{ pkgs, ... }:
{
  imports = [ ./remote.nix ./secrets/work.nix ];

  home.packages = with pkgs; [
    git-town
  ];
}
