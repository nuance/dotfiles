{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/google-compute-image.nix")
  ];

  boot.kernelParams = [
    "console=tty1"
    "console=ttyS0,115200"
  ];

  services.journaldriver.enable = true;
}
