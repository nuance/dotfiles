# Heavily based on https://gist.github.com/sorki/548de08f621b066c94f0c36a7a78cc41#file-configuration-nix-L9
{ config, lib, pkgs, ... }:

{
  imports = [
    <nixos/nixos/modules/installer/cd-dvd/sd-image-raspberrypi.nix>
  ];

  # Keep it ready for `dd`ing it on the SD card
  sdImage = {
    compressImage = false;
  };

  nixpkgs = {
    crossSystem = {
      system = "armv6l-linux";
      platform = lib.systems.platforms.raspberrypi;
    };

    overlays = [
      (self: super: {
        mailutils = null; # Does not cross-compile. Missing binary breaks sendmail functionality of smartd
      })
    ];
  };

  # closure minification
  environment.noXlibs = true;
  services.xserver.enable = false;
  services.xserver.desktopManager.xterm.enable = lib.mkForce false;

  # this pulls too much graphical stuff
  services.udisks2.enable = lib.mkForce false;
  # this pulls spidermonkey and firefox
  security.polkit.enable = false;

  boot.supportedFilesystems = lib.mkForce [ "vfat" ];
  i18n.supportedLocales = lib.mkForce [ (config.i18n.defaultLocale + "/UTF-8") ];

  documentation.enable = false;
  documentation.man.enable = false;
  documentation.nixos.enable = false;

  ## Combats the default setting of wpa_supplicant not starting on installation devices
  ## https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/installation-device.nix#L74
  # systemd.services.wpa_supplicant.wantedBy = lib.mkOverride 49 [ "multi-user.target" ];
}
