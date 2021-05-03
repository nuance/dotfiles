{ overlays, ... }:
{

  system = "x86_64-darwin";

  homeDirectory = "/Users/matt";
  username = "matt";

  stateVersion = "21.05";

  configuration = { pkgs, lib, config, ... }:
    {
      nixpkgs.overlays = overlays;
      programs.bash.shellAliases.flake-rebuild = "(cd ~/dotfiles/home-manager && ${../rebuild.sh} work-pro)";

      home.packages = with pkgs; [ go gopls goimports ];

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
    };
}
