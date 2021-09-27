{ ... }:
let setup-function = ''
    function setup-remote-host () {
      hostname=$1; shift;

      scp -q ~/.config/git/config $hostname:.gitconfig
      scp -q ${./setup-remote-host/remote-profile} $hostname:.remote-profile
      scp -q ${./setup-remote-host/secrets/remote-editor} $hostname:.remote-editor
      scp -q ${./emacs/secrets/server} $hostname:.remote-emacs-server
      ssh $hostname mkdir -p bin

      ssh $hostname "
        [[ -e .bash_profile ]] || ( echo -n 'Creating .bash_profile... '; cat > .bash_profile <<EOF && echo ok )
# -*- mode: sh -*-

# include .profile if it exists
[[ -f ~/.profile ]] && . ~/.profile

# include .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc
EOF
"
      ssh $hostname "
        [[ \$(grep REMOTE-EDITOR ~/.bash_profile) ]] || ( echo -n 'Adding .remote-profile to .bash_profile... '; cat >> .bash_profile <<EOF && echo ok )
# start REMOTE-EDITOR
[[ -f ~/.remote-profile ]] && . ~/.remote-profile
# end REMOTE-EDITOR
EOF
"
    }
  '';
in {
  programs.bash.initExtra = setup-function;
  programs.zsh.initExtra = setup-function;
}
