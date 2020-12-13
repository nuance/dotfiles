{ ... }:
{
  programs.bash = {
    enable = true;

    sessionVariables = {
      BASH_SILENCE_DEPRECATION_WARNING = 1;
      PYTHONIOENCODING = "UTF-8";
      EDITOR = "${../files/editor}";
      CLICOLOR = 1;
    };

    initExtra = ''
      if [[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
          # shellcheck source=/dev/null
          . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      fi

      if [[ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]]; then
          # shellcheck source=/dev/null
          . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
          export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      fi

      e() {
          $EDITOR "$@"
      }

      if [[ -d ~/.bash_includes ]]; then
          for src in ~/.bash_includes/*; do
              . "$src"
          done
      fi

      # PS1 is "(remote host name)? (directory) ([non-zero exit code])? $"
      export PS1="\[\033[0;32m\]\W\[\033[00m\] \$(exit_code="\$?"; ((\$exit_code)) && echo \"\[\033[0;31m\][\$exit_code] $\" || echo \"\[\033[0;32m\]$\" )\[\033[00m\] "
      if [[ "$(uname)" != Darwin ]]; then
          export PS1="\[\033[0;33m\]\h\[\033[00m\] $PS1"
      fi
    '';

    shellAliases = {
      g = "git";
      gg = "git grep";
      onepage = "head -n $(echo \"$(tput lines) - 2\" | bc)";
    };

    shellOptions = [
      # Append to history file rather than replacing it.
      "histappend"

      # check the window size after each command and, if
      # necessary, update the values of LINES and COLUMNS.
      "checkwinsize"
    ];
  };
}
