{ pkgs, ... }:
{
  programs.bash = {
    enable = true;

    sessionVariables = {
      BASH_SILENCE_DEPRECATION_WARNING = 1;
      PYTHONIOENCODING = "UTF-8";
      CLICOLOR = 1;
    };

    initExtra = ''
      # PS1 is "(directory) ([non-zero exit code])? $"
      export PS1="\[\033[0;32m\]\W\[\033[00m\] \$(exit_code="\$?"; ((\$exit_code)) && echo \"\[\033[0;31m\][\$exit_code] $\" || echo \"\[\033[0;32m\]$\" )\[\033[00m\] "
    '';

    shellAliases = {
      g = "git";
      gg = "git grep";
      onepage = "head -n $(echo \"$(tput lines) - 2\" | bc)";
      e = "$EDITOR";
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
