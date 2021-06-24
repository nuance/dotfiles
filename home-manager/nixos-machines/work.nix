{ pkgs, ... }:
{
  imports = [ ./remote.nix ./secrets/work.nix ../machines/secrets/work.nix ];

  home.packages = with pkgs; [
    git-town
  ];
}
