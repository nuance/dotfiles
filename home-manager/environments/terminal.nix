# Configuration intended for a non-remote machine
{ ... }:
{
  imports = [
    ../programs/setup-remote-host.nix
    ../programs/emacs.nix
    ../programs/ssh.nix
  ];
}
