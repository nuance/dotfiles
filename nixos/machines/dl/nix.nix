{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    binaryCaches = [ "https://nuance.cachix.org" "https://nix-community.cachix.org" ];
    binaryCachePublicKeys = [ "nuance.cachix.org-1:dAmExyWto63NWNdWaXvVLwmwewO+e/bXs4uAv9uf1No=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };
}
