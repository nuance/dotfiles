{ overlays }:
{ pkgs, lib, ... }:
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

  services.eternal-terminal.enable = true;
  networking.firewall.allowedTCPPorts = [ 2022 ];

  services.tailscale.enable = true;
  programs.mosh.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = lib.mkForce "no";
    passwordAuthentication = false;
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:nuance/dotfiles";
    allowReboot = true;
  };
}
