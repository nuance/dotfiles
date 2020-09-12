{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cacert
    curl
    direnv
    emacs
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
