{ pkgs, lib, ... }:
let
  rawPackage = (pkgs.emacsGit.override {
    nativeComp = true;
    withXwidgets = true;
  });
  oaPackage = (if pkgs.stdenv.isLinux then rawPackage else
  (
    rawPackage.overrideAttrs (
      oa: { buildInputs = oa.buildInputs ++ [ pkgs.darwin.apple_sdk.frameworks.WebKit ]; }
    )));
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs/init.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    package = oaPackage;
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
      emacs-all-the-icons-fonts
      ibm-plex
      graphviz-nox
      fd
      ripgrep
      rnix-lsp
    ];

  home.file = {
    ".emacs.d/init.org" = {
      source = ./emacs/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\"";
    };
  };

  programs.bash.sessionVariables.EDITOR = "${emacs}/bin/emacsclient -f $HOME/.emacs.d/server/server";
  programs.zsh.sessionVariables.EDITOR = "${emacs}/bin/emacsclient";

  programs.bash.shellAliases.en = "$EDITOR -n";
  programs.zsh.shellAliases.en = "$EDITOR -n";
}
