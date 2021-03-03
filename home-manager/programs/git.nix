{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Matthew Jones";
    userEmail = "matt@mhjones.org";
    aliases = {
      st = "status -s";
      ci = "commit";
      cim = "commit -am";
      ca = "commit --amend -a --no-edit";
      br = "branch -vv --sort=\"-committerdate\"";
      co = "checkout";
      df = "diff";
      dff = "diff --summary --stat";
      lg = "log -p";
      ds = "diff --staged";
      dss = "diff --staged --summary --stat";
      u = "fetch -n origin";
      p = "rebase origin/master";
      up = "! git u && git p";
      ms = "merge --squash";
      touch = "commit --allow-empty";
      rc = "rebase --continue";
      push = "push -u";
      pushf = "push --force-with-lease";
      changed = "! git diff --diff-filter=ACMRTUX --name-only `git merge-base HEAD origin/master` | more";
      changed-diff = "! git diff --diff-filter=ACMRTUX `git merge-base HEAD origin/master`";
      squash = "git reset --soft `git merge-base HEAD origin/master`";
    };

    extraConfig = {
      merge = {
        summary = true;
      };

      color = {
        ui = "auto";
      };

      push = {
        default = "current";
      };
    };
  };

  home.packages = [ pkgs.git-crypt ];
}