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
      ./cuda.nix
      ./nix.nix
    ];

  networking.hostName = "dl";

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_5_4;
  boot.kernelParams = [ "nordrand" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.sudo.wheelNeedsPassword = false;
  users.extraUsers.matt = {
    createHome = true;
    home = "/home/matt";
    description = "Matt";
    group = "users";
    extraGroups = [ "wheel" ];
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMo1DyxU9VJguOa8f78QzlKFfR/ZB1DHoXBVSOtzZL8Q matt"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/wTtWs6/0SCrhCMq1NzJhyzYEOoUDrBS2rrIGxUdIA matt@ipad"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH02uqD2POyekqgyDmVfwTMZ8pnXoTqxZsnWAvSF7Kvg matt@iphone"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAWaAo1P8+vAISe8U0++gXsIVr2zNGafHmHgqZFkDspj biz@mhjones.org"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKhFzdkHyJHZ+tDSi3+3GUM4Qa3d5cXQOVQ7AYyGg+y32+UBFU2Y/vspt1LatfVASXrEc9MIrwtVwjhxYCCGcOM= ssh-key@secretive.Matthew’s-MacBook-Pro.local"
    ];
  };

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
