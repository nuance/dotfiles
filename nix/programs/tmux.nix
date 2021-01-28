{ ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = "setw -g mouse on";
    prefix = "C-o";
  };
}
