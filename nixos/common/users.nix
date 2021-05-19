{ pkgs, lib, ... }:
let keys = lib.splitString "\n" (builtins.readFile ./github-keys.txt);
in
{
  security.sudo.wheelNeedsPassword = false;
  users.extraUsers.matt = {
    createHome = true;
    home = "/home/matt";
    description = "Matt";
    group = "users";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = keys;
  };
}
