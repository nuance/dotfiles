{ config, pkgs, ... }:
let
  emacs = pkgs.emacsGcc;
in
{

  nixpkgs.overlays = [
    (
      import (
        builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
        }
      )
    )
  ];

  home.packages = with pkgs; [
    curl
    emacs
    gnupg1
    go
    ispell
    nixpkgs-fmt
    pinentry_mac
    python37Packages.black
    python37Packages.flake8
    tree
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    "Library/KeyBindings/DefaultKeyBinding.dict".source = ./EmacsKeyBinding.dict;
    "Applications/Emacs.app".source = "${emacs}/Applications/Emacs.app";
    "bin/emacsclient".source = "${emacs}/bin/emacsclient";
    "bin/editor".source = ../editor;
    ".bashrc".source = ../bashrc;
    ".bash_profile".source = ../bash_profile;
    ".bash_includes/no_op.sh".text = "";
    ".emacs.d/init.org" = {
      source = ../emacs.d/init.org;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${emacs}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };
    ".emacs.d/straight/versions/default.el" = {
      source = ../straight-package-versions.el;
      onChange = "cd ~/.emacs.d ; ${emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${emacs}/bin/emacs --batch --load init.el --eval \"(straight-thaw-versions)\";";
    };

    ".home-manager-trigger-config" = {
      text = ''
        #!/usr/bin/env bash

        echo -n "Applying configuration... "

        defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
        defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)

        echo "done."
      '';
      onChange = "/usr/bin/env bash ~/.home-manager-trigger-config";
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mhj";
  home.homeDirectory = "/Users/mhj";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
