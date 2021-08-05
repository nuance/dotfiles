{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/google-compute-config.nix")
  ];

  services.journaldriver.enable = true;
}
