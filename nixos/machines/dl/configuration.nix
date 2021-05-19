# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./networking.nix
      ./nvidia.nix
      ./cuda.nix
      ../../common/common.nix
    ];

  networking.hostName = "dl";

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  nixpkgs.config.allowUnfree = true;
  boot.kernelParams = [ "nordrand" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    mosh
    pciutils
    cachix
  ];

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
