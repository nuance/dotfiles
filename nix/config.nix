{ pkgs, ... }:
let
  emacs = pkgs.emacsGcc;
in
{

  nixpkgs.overlays = [
    (
      import (
        builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/18a89a8278ef33d4ec5b878d731ed6bf3b0fc978.tar.gz;
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

        defaults write com.apple.dock autohide -bool True # turn on dock auto-hiding

        if [ ! -d ~/Library/Fonts/OpenType ]; then
            ${pkgs.curl}/bin/curl -L https://github.com/IBM/plex/releases/download/v5.1.3/OpenType.zip -o /tmp/plex.zip
            cd ~/Library/Fonts && unzip /tmp/plex.zip
        fi

        if [ ! -d ~/Library/Fonts/Icons ]; then
            mkdir ~/Library/Fonts/Icons
            for font in all-the-icons file-icons fontawesome material-design-icons octicons weathericons; do
               ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/$font.ttf -o ~/Library/Fonts/Icons/$font.ttf
            done
        fi

        echo "done."
      '';
      onChange = "/usr/bin/env bash ~/.home-manager-trigger-config";
    };
  };
}
