{ config, pkgs, ... }:
let
  ical-to-diary = (import ../../utilities/ical-to-diary/default.nix {
    inherit pkgs;
  });
  ropen-server = (import ../../utilities/ropen-server/default.nix {
    inherit pkgs;
  });
  homeDirectory = config.home.homeDirectory;
in
{
  home.packages = [ ical-to-diary ropen-server ];

  # Run ical-to-diary once a minute
  home.file."Library/LaunchAgents/org.mhjones.ical-to-diary.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>org.mhjones.ical-to-diary</string>
          <key>Program</key>
          <string>${ical-to-diary}/bin/ical-to-diary</string>
          <key>StartInterval</key>
          <integer>60</integer>
          <key>WorkingDirectory</key>
          <string>${homeDirectory}</string>
        </dict>
      </plist>
    '';

    onChange = "/bin/launchctl stop org.mhjones.ical-to-diary; /bin/launchctl unload ~/Library/LaunchAgents/org.mhjones.ical-to-diary.plist ; /bin/launchctl load ~/Library/LaunchAgents/org.mhjones.ical-to-diary.plist && /bin/launchctl start org.mhjones.ical-to-diary";
  };

  # Snapshot org library once a minute
  home.file."Library/LaunchAgents/org.mhjones.org-snapshot.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>org.mhjones.org-snapshot</string>
          <key>Program</key>
          <string>${./macos/snapshot-org.sh}</string>
          <key>StartInterval</key>
          <integer>60</integer>
          <key>WorkingDirectory</key>
          <string>${homeDirectory}/org</string>
        </dict>
      </plist>
    '';

    onChange = "/bin/launchctl stop org.mhjones.org-snapshot; /bin/launchctl unload ~/Library/LaunchAgents/org.mhjones.org-snapshot.plist ; /bin/launchctl load ~/Library/LaunchAgents/org.mhjones.org-snapshot.plist && /bin/launchctl start org.mhjones.org-snapshot";
  };


  home.file.".auto-dark-mode/auto-dark-mode.sh".source = ./macos/auto-dark-mode.sh;
  home.file.".auto-dark-mode/auto-dark-mode.swift".source = ./macos/auto-dark-mode.swift;

  # start auto-dark-mode at launch
  home.file."Library/LaunchAgents/org.mhjones.auto-dark-mode.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>org.mhjones.auto-dark-mode</string>
          <key>Program</key>
          <string>${homeDirectory}/.auto-dark-mode/auto-dark-mode.sh</string>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>${homeDirectory}/.auto-dark-mode</string>
        </dict>
      </plist>
    '';

    onChange = "/bin/launchctl stop org.mhjones.auto-dark-mode; /bin/launchctl unload ~/Library/LaunchAgents/org.mhjones.auto-dark-mode.plist ; /bin/launchctl load ~/Library/LaunchAgents/org.mhjones.auto-dark-mode.plist && /bin/launchctl start org.mhjones.auto-dark-mode";
  };

  # start ropen-server
  home.file."Library/LaunchAgents/org.mhjones.ropen-server.plist" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>org.mhjones.ropen-server</string>
          <key>Program</key>
          <string>${ropen-server}/bin/ropen-server</string>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>${homeDirectory}</string>
        </dict>
      </plist>
    '';

    onChange = "/bin/launchctl stop org.mhjones.ropen-server; /bin/launchctl unload ~/Library/LaunchAgents/org.mhjones.ropen-server.plist ; /bin/launchctl load ~/Library/LaunchAgents/org.mhjones.ropen-server.plist && /bin/launchctl start org.mhjones.ropen-server";
  };

}
