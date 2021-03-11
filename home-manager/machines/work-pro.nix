{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/matt";
  username = "matt";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${../rebuild.sh} work-pro)";

      home.packages = with pkgs; [ go gopls ];

      imports = [
        ../config.nix
        ../environments/macos.nix
        ../environments/terminal.nix
        ../programs/emacs-server.nix
        ../environments/macos-launch-agents.nix
        ./secrets/work-pro.nix
      ];

      programs.bash.sessionVariables = {
        NVM_DIR = "/Users/matt/.nvm";
      };

      programs.bash.initExtra = ''
        . "/Users/matt/.nvm/nvm.sh"
        . "/Users/matt/.nvm/bash_completion"
      '';

      programs.ssh.serverAliveCountMax = 1;
      programs.ssh.serverAliveInterval = 240;

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
