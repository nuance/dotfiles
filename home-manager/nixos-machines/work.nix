{ pkgs, ... }:
{
  imports = [ ./remote.nix ./secrets/work.nix ];
}
