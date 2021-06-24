{ pkgs, lib, ... }:
let keys = lib.splitString "\n" (builtins.readFile ./github-keys.txt);
in
{
  security.sudo.wheelNeedsPassword = false;
  users.users.matt = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = keys;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
  };

  users.users.matt-work = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = keys;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
  };
}
