{ ... }:
{
  programs.bash.initExtra = ''
    function setup-remote-host () {
      hostname=$1; shift;

      scp ${./setup-remote-host/remote-profile} $hostname:.remote-profile
      scp ${./setup-remote-host/secrets/remote-editor} $hostname:.remote-editor
      scp ${./emacs/secrets/server} $hostname:.remote-emacs-server
      ssh $hostname "echo -n 'Adding .remote-profile to .bash_profile... ' ; [[ \$(grep REMOTE-EDITOR ~/.bash_profile) ]] || echo '# start REMOTE-EDITOR\n[[-f ~/.remote-profile]] && . ~/.remote-profile\n# end REMOTE-EDITOR\n' >> .bash_profile && echo ok"
    }
  '';
}
