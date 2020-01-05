{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    direnv
    emacs
    go
    google-cloud-sdk
    ispell
    mosh
    cacert
    pv
    python37
    python37Packages.python-language-server
    python37Packages.pyls-black
    python37Packages.pyls-isort
    python37Packages.pyls-mypy
    qrencode
    ripgrep
    shellcheck
    tree
    xquartz
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
}
