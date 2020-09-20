{ config, pkgs, ... }:
let
  unstable = import <unstable> { };
in
{
  home.packages = with pkgs; [
    direnv
    ispell
    gnupg1
    go
    unstable.gopls
    nixpkgs-fmt
    mosh
    pv
    shellcheck
    tree
    curl
    ripgrep
    rsync
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.emacs = {
    enable = true;
    package = unstable.emacs-nox;
  };

  services.emacs = {
    enable = true;
  };

  home.file = {
    "bin/emacsclient".source = "${unstable.emacs-nox}/bin/emacsclient";
    "bin/editor".source = ../editor;
    ".bash_profile".source = ../bash_profile;
    ".bash_includes/no_op.sh".text = "";

    ".emacs.d/init.org" = {
      source = ../emacs.d/init.org;
      onChange = "cd ~/.emacs.d ; ${unstable.emacs-nox}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${unstable.emacs-nox}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
    ".emacs.d/straight/versions/default.el" = {
      source = ../straight-package-versions.el;
      onChange = "cd ~/.emacs.d ; ${unstable.emacs-nox}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${unstable.emacs-nox}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
