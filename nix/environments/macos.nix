{ pkgs, ... }:
let
  ical-to-diary = import ../../ical-to-diary/default.nix;
in
{
  home.packages = with pkgs; [
    pinentry_mac
    ical-to-diary
  ];

  home.file = {
    "Library/KeyBindings/DefaultKeyBinding.dict".source = ./macos/EmacsKeyBinding.dict;

    ".home-manager-trigger-config" = {
      text = ''
        #!/usr/bin/env bash

        echo -n "Applying configuration... "

        defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
        defaults write -g InitialKeyRepeat -int 12 # normal minimum is 15 (225 ms)

        defaults write com.apple.dock autohide -bool True # turn on dock auto-hiding

        if [ ! -d ~/Library/Fonts/OpenType ]; then
            ${pkgs.curl}/bin/curl -L https://github.com/IBM/plex/releases/download/v5.1.3/OpenType.zip -o /tmp/plex.zip
            cd ~/Library/Fonts && unzip /tmp/plex.zip
        fi

        if [ ! -d ~/Library/Fonts/Icons ]; then
            mkdir ~/Library/Fonts/Icons
            for font in all-the-icons file-icons fontawesome material-design-icons octicons weathericons; do
               ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/domtronn/all-the-icons.el/master/fonts/$font.ttf -o ~/Library/Fonts/Icons/$font.ttf
            done
        fi

        echo "done."
      '';
      onChange = "/usr/bin/env bash ~/.home-manager-trigger-config";
    };
  };
}
