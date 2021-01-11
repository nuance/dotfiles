{ pkgs, ... }:
let
  emacs = pkgs.emacsGcc;
in
{
  nixpkgs.overlays = [
    (
      import (
        builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/d2245bfc7c35042c04f69c67df166a02be853b32.tar.gz;
        }
      )
    )
  ];

  home.packages = with pkgs; [
    emacs
    gnupg1
    ispell
    nixpkgs-fmt
    python37Packages.black
    python37Packages.flake8
  ];

  home.file = {
    "Applications/Emacs.app".source = "${emacs}/Applications/Emacs.app";
    "bin/emacsclient".source = "${emacs}/bin/emacsclient";

    ".emacs.d/init.org" = {
      source = ../files/emacs/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${emacs}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
    ".emacs.d/straight/versions/default.el" = {
      source = ../files/emacs/straight-package-versions.el;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${emacs}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
  };
}
