{ lib, ... }:
{
  imports = [ ./secrets/wifi.nix ];

  hardware.enableAllFirmware = true;
  networking.wireless.enable = true;

  # networking.firewall = {
  #   allowedUDPPorts = [ 51820 60000 60001 ];
  # };

  services.tailscale.enable = true;
  services.eternal-terminal.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp5s0.useDHCP = true;

  services.openssh = {
    enable = true;
    permitRootLogin = lib.mkForce "no";
    passwordAuthentication = false;
  };
}
