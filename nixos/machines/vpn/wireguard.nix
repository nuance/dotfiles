{ lib, pkgs, config, ... }:
let wg-pubkeys = lib.importJSON ./wg-pubkeys.json;
in
{
  environment.systemPackages = with pkgs; [
    wireguard
    wireguard-tools
    unbound
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

  # enable NAT
  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];

    # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
    # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
    extraCommands = ''iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE'';
  };

  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that Wireguard listens to. Must be accessible by the client.
      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      # Path to the private key file.
      privateKeyFile = "/root/wg.private";

      peers = wg-pubkeys;
    };
  };

  services.unbound.enable = true;
  services.unbound.allowedAccess = [ "127.0.0.0/24" "10.100.0.0/24" ];
  services.unbound.interfaces = [ "127.0.0.1" "10.100.0.1" ];

}
