{ pkgs, lib, ... }:
let
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs/init.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    package = pkgs.emacsGcc;
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
    ];

  home.file = {
    "Applications/Emacs.app".source = "${emacs}/Applications/Emacs.app";
    ".emacs.d/init.org".source = ./emacs/init.org;
  };
}
