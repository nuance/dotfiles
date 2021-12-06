{ pkgs, lib, ... }:
let
  emacs = (pkgs.emacsWithPackagesFromUsePackage {
    config = ./emacs/init.org;
    alwaysEnsure = true;
    alwaysTangle = true;
    package = (
      (
        pkgs.emacsUnstable.override {
          withX = false;
          withGTK2 = false;
          withGTK3 = false;
        }
      ).overrideAttrs (
        oa: {
          name = "${oa.name}-nox";
        }
      )
    );
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
      clang-tools
      gopls
    ];

  home.file = {
    ".emacs.d/init.org" = {
      source = ./emacs/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\"";
    };
    ".emacs.d/server/server.el".source = ./emacs/secrets/server;
  };

  programs.bash.sessionVariables.EDITOR = "${setup-remote-host/secrets/remote-editor}";
  programs.zsh.sessionVariables.EDITOR = "${setup-remote-host/secrets/remote-editor}";

  programs.bash.shellAliases.en = "$EDITOR -n";
  programs.zsh.shellAliases.en = "$EDITOR -n";
}
