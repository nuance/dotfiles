{ pkgs, lib, ... }:
let
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs/init.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    package = (pkgs.emacsGcc.override {
      withXwidgets = true;
    }).overrideAttrs
      (oa: {
        buildInputs = oa.buildInputs ++ [ pkgs.darwin.apple_sdk.frameworks.WebKit ];
      });
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
      graphviz-nox
      fd
      ripgrep
      pandoc
    ];

  programs.mu.enable = true;

  home.file = {
    ".emacs.d/init.org" = {
      source = ./emacs/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\"";
    };
    ".emacs.d/site-lisp/mu4e-thread-folding.el".source = ./emacs/mu4e-thread-folding.el;
  };

  programs.bash.sessionVariables = {
    EDITOR = "${emacs}/bin/emacsclient -f /Users/matt/.emacs.d/server/server";
  };
}
