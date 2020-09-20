{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cacert
    curl
    direnv
    emacs
    ghostscript
    gnupg1
    go
    google-cloud-sdk
    gopls
    ispell
    mosh
    pv
    ripgrep
    rsync
    shellcheck
    texlive.combined.scheme-small
    tree
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    "Library/KeyBindings/DefaultKeyBinding.dict".source = ./EmacsKeyBinding.dict;
    "Applications/Emacs.app".source = "${pkgs.emacs}/Applications/Emacs.app";
    "bin/emacsclient".source = "${pkgs.emacs}/bin/emacsclient";
    "bin/editor".source = ../editor;
    ".bash_profile".source = ../bash_profile;
    ".bash_includes/no_op.sh".text = "";
    ".emacs.d/init.org" = {
      source = ../emacs.d/init.org;
      onChange = "cd ~/.emacs.d ; ${pkgs.emacs}/bin/emacs --batch -l ob-tangle --eval \"(org-babel-tangle-file \\\"init.org\\\")\" ; ${pkgs.emacs}/bin/emacs --batch --load init.el;";
    };
    ".emacs.d/straight/versions/default.el".source = ../straight-package-versions.el;

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
