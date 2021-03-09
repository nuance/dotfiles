{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/matt";
  username = "matt";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${../rebuild.sh} m1-pro)";
      imports = [ ../config.nix ../environments/macos.nix ../environments/terminal.nix ../programs/emacs-server.nix ];

      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home.username = "matt";
      home.homeDirectory = "/Users/matt";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "21.03";
    };
}
