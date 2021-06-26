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
    binutils
    zsh
  ];

  services.eternal-terminal = {
    enable = true;
    port = 443;
  };
  networking.firewall.allowedTCPPorts = [ 443 ];

  services.tailscale.enable = true;

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
