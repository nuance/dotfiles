{
  programs.ssh.enable = true;
  programs.ssh.matchBlocks = {
    "dl" = {
      forwardAgent = true;
      remoteForwards = [
        {
          bind.port = 40000;
          host.address = "localhost";
          host.port = 40000;
        }
      ];
    };
  };
}
