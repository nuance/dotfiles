{ lib, ... }:
let hosts = [ "dl" "print-server" ];
in
{
  programs.ssh.enable = true;

  programs.ssh.matchBlocks =
    lib.genAttrs hosts
      (host: {
        forwardAgent = true;
      }) // {
      "*" = {
        remoteForwards = [
          {
            bind.port = 40000;
            host.address = "localhost";
            host.port = 40000;
          }
          {
            bind.port = 40001;
            host.address = "localhost";
            host.port = 40001;
          }
        ];
      };
    };
}
