{ ... }:
{
  home.file = {
    ".emacs.d/server/server".source = ./emacs/secrets/server;
    ".emacs.d/server.el".source = ./emacs/secrets/server.el;
  };
}
