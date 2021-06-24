{ pkgs, lib, ... }:
let
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs/init.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    package = (pkgs.emacsGit-nox.override {
      nativeComp = true;
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
      python3Packages.black
      python3Packages.flake8
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
    ".emacs.d/server/server.el".source = ./emacs/secrets/server;
  };

  programs.bash.sessionVariables.EDITOR = "${emacs}/bin/emacsclient -f $HOME/.emacs.d/server/server";
  programs.zsh.sessionVariables.EDITOR = "${emacs}/bin/emacsclient -f $HOME/.emacs.d/server/server";

  programs.bash.shellAliases.en = "$EDITOR -n";
  programs.zsh.shellAliases.en = "$EDITOR -n";
}
