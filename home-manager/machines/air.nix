{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/matt";
  username = "matt";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${../rebuild.sh} air)";
      imports = [ ../config.nix ../environments/macos.nix ];

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "20.03";
    };
}
