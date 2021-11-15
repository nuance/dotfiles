{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = false;

    initExtraFirst = ''
      [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
    '';

    defaultKeymap = "emacs";

    history.ignorePatterns = [ "ls" "cd" "exit" ];

    sessionVariables = {
      PYTHONIOENCODING = "UTF-8";
      CLICOLOR = 1;
      PROMPT = "%F{green}%1~%f %(?.%F{green}.%F{red}[%?] )$%f ";
    };

    shellAliases = {
      g = "git";
      gg = "git grep";
      onepage = "head -n $(echo \"$(tput lines) - 2\" | bc)";
      e = "$EDITOR";
    };
  };
}
