{ pkgs, ... }:
{
  home.packages = with pkgs; [
    XBar
  ];

  home.file."Library/Application\ Support/xbar/plugins/mu-inbox-count.1m.sh" = {
    text = ''
      #!/usr/bin/env bash
      mu find maildir:"/gmail/Inbox" and flag:unread 2>/dev/null | wc -l
      echo ---
      echo 'Inbox | shell=open | param1="emacs://mu?"'
    '';
    executable = true;
  };
}
