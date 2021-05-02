{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/runner";
  username = "runner";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${../rebuild.sh} github-macos-ci)";
      imports = [ ../config.nix ../environments/macos.nix ];

      # Home Manager needs a bit of information about you and the
      # paths it should manage.
      home.username = "runner";
      home.homeDirectory = "/Users/runner";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "21.05";
    };
}
