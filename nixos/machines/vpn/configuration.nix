{ overlays }:
{ pkgs, ... }:
{
  nixpkgs.overlays = overlays;

  imports = [
    ./google-cloud.nix
    ./wireguard.nix
    ../../common/common.nix
  ];

  networking.hostName = "vpn";
  system.stateVersion = "18.09";

  environment.systemPackages = with pkgs; [
    mosh
    binutils
    zsh
  ];

  services.tailscale.enable = true;
  programs.mosh.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = "github:nuance/dotfiles";
    allowReboot = true;
  };
}
