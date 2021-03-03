{ pkgs, lib, ... }:
let
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs/init.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    package = pkgs.emacs; # pkgs.emacsGcc
  });
in
{
  home.packages = with pkgs;
    [
      emacs
      gnupg1
      ispell
      nixpkgs-fmt
      python37Packages.black
      python37Packages.flake8
      emacs-all-the-icons-fonts
      ibm-plex
    ];

  home.file = {
    ".emacs.d/init.org" = {
      source = ./emacs/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\"";
    };
  };

  programs.bash.sessionVariables = {
    EDITOR = "${emacs}/bin/emacsclient -f /Users/matt/.emacs.d/server/server";
  };
}
