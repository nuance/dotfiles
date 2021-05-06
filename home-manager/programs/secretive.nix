{ ... }:
{
  programs.bash.sessionVariables = {
    SSH_AUTH_SOCK = "/Users/matt/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
  };

  programs.zsh.sessionVariables = {
    SSH_AUTH_SOCK = "/Users/matt/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
  };
}
