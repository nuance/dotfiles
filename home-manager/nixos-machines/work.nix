{ pkgs, ... }:
{
  imports = [ ./remote.nix ./secrets/work.nix ../machines/secrets/work.nix ];

  home.packages = with pkgs; [
    git-town
    python3Packages.nbdime
  ];

  programs.git.aliases = {
    fix = "! git pychanged | xargs black && git pychanged | xargs isort";
    lint = "! git pychanged | xargs flake8 && git pychanged | xargs pyright";
    test = "! git pychanged | xargs dirname | sort | uniq | xargs pytest";
    flt = "! git fix && git lint && git test";
    append = "town append";
    hack = "town hack";
    kill = "town kill";
    new-pull-request = "town new-pull-request";
    prepend = "town prepend";
    prune-branches = "town prune-branches";
    rename-branch = "town rename-branch";
    repo = "town repo";
    ship = "town ship";
    sync = "town sync";
  };

  programs.git.includes = [
    {
      "path" = "${./nbdime.inc}";
    }
  ];
}
