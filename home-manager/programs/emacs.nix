{ pkgs, lib, ... }:
let
  emacs = pkgs.emacsGcc;
in
{
  home.packages = with pkgs; [
    emacs
    gnupg1
    ispell
    nixpkgs-fmt
    python37Packages.black
    python37Packages.flake8
    emacs-all-the-icons-fonts
  ];

  home.file = {
    "Applications/Emacs.app".source = "${emacs}/Applications/Emacs.app";
    ".emacs.d/server/server".source = ./emacs/secrets/server;
    ".emacs.d/server.el".source = ./emacs/secrets/server.el;

    ".emacs.d/init.org" = {
      source = ./emacs/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${emacs}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
    ".emacs.d/straight/versions/default.el" = {
      source = ./emacs/straight-package-versions.el;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${emacs}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
  };
}
