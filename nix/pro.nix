{ config, pkgs, ... }:

let emacs = pkgs.emacsGit-nox; in
{
 nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
 ];

  home.packages = with pkgs; [
    direnv
    emacs
    ispell
    mosh
    pv
    ripgrep
    shellcheck
    tree
    curl
    rsync
    watch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    "Library/KeyBindings/DefaultKeyBinding.dict".source = ./EmacsKeyBinding.dict;
    "Applications/Emacs.app".source = "${emacs}/Applications/Emacs.app";
    "bin/emacsclient".source = "${emacs}/bin/emacsclient";
    ".bashrc".source = ../bashrc;
    ".bash_profile".source = ../bash_profile;
    ".bash_includes/no_op.sh".text = "";
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
