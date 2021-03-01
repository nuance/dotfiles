{ config, lib, pkgs, ... }:
let
  profileDirectory = config.home.profileDirectory;
in
{
  home.packages = [ pkgs.nixFlakes ];

  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    substituters = https://cache.nixos.org https://nuance.cachix.org https://nix-community.cachix.org
    trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nuance.cachix.org-1:dAmExyWto63NWNdWaXvVLwmwewO+e/bXs4uAv9uf1No= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
    build-max-jobs = 4
  '';

  home.sessionVariablesExtra = ''
    . "${pkgs.nix}/etc/profile.d/nix.sh"
  '';

  # We need to source both nix.sh and hm-session-vars.sh as noted in
  # https://github.com/nix-community/home-manager/pull/797#issuecomment-544783247
  programs.bash.initExtra = ''
    . "${pkgs.nix}/etc/profile.d/nix.sh"
    . "${profileDirectory}/etc/profile.d/hm-session-vars.sh"
  '';
}
