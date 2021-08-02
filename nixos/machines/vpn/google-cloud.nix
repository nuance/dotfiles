{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/google-compute-image.nix")
  ];

  environment.systemPackages = with pkgs; [
    google-cloud-sdk-gce
  ];
  boot.kernelParams = [
    "console=tty1"
    "console=ttyS0,115200"
  ];

  services.journaldriver.enable = true;
}
