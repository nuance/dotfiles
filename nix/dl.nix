{ config, pkgs, ... }:

let
  emacs = pkgs.emacsUnstable-nox;
  unstable = import <unstable> {};
in
{
  nixpkgs.overlays = [
    (
      import (
        builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/641c77b05036f76d5b48b6bcdb817ba81e05e4cb.tar.gz;
          sha256 = "1gz78dy6g2jfrdnr0mxq3ppsl26nrr24s40wbpj0f8r14x8w87y9";
        }
      )
    )
  ];

  home.packages = with pkgs; [
    direnv
    emacs
    jupyter_core
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
    rsync
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    "bin/emacsclient".source = "${emacs}/bin/emacsclient";
    "bin/editor".source = ../editor;
    ".bash_profile".source = ../bash_profile;
    ".bash_includes/no_op.sh".text = "";
    ".emacs.d/straight/versions/default.el".source = ../straight-package-versions.el;
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
