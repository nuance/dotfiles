{ ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = ''
      setw -g mouse on

      # rebind main key: C-o
      unbind C-b
      set -g prefix C-o
      bind C-o send-prefix
    '';
  };
}
