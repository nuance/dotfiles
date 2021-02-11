{ lib, pkgs, targets, ... }:
let
  ical-to-diary = import ../../ical-to-diary/default.nix;
in
{
  home.packages = with pkgs; [
    pinentry_mac
    ical-to-diary
  ];

  targets.darwin.keybindings = {
    /* Ctrl shortcuts */
    "^l" = "centerSelectionInVisibleArea:"; /* C-l          Recenter */
    "^/" = "undo:"; /* C-/          Undo */
    "^_" = "undo:"; /* C-_          Undo */
    "^ " = "setMark:"; /* C-Spc        Set mark */
    "^\@" = "setMark:"; /* C-@          Set mark */
    "^w" = "deleteToMark:"; /* C-w          Delete to mark */

    /* Meta shortcuts */
    "~f" = "moveWordForward:"; /* M-f          Move forward word */
    "~b" = "moveWordBackward:"; /* M-b          Move backward word */
    "~<" = "moveToBeginningOfDocument:"; /* M-<          Move to beginning of document */
    "~>" = "moveToEndOfDocument:"; /* M->          Move to end of document */
    "~v" = "pageUp:"; /* M-v          Page Up */
    "~/" = "complete:"; /* M-/          Complete */
    "~c" =
      [
        "capitalizeWord:" /* M-c          Capitalize */
        "moveForward:"
        "moveForward:"
      ];
    "~u" =
      [
        "uppercaseWord:" /* M-u          Uppercase */
        "moveForward:"
        "moveForward:"
      ];
    "~l" =
      [
        "lowercaseWord:" /* M-l          Lowercase */
        "moveForward:"
        "moveForward:"
      ];
    "~d" = "deleteWordForward:"; /* M-d          Delete word forward */
    "^~h" = "deleteWordBackward:"; /* M-C-h        Delete word backward */
    "~\U007F" = "deleteWordBackward:"; /* M-Bksp       Delete word backward */
    "~t" = "transposeWords:"; /* M-t          Transpose words */
    "~\@" =
      [
        "setMark:" /* M-@          Mark word */
        "moveWordForward:"
        "swapWithMark"
      ];
    "~h" =
      [
        "setMark:" /* M-h          Mark paragraph */
        "moveToEndOfParagraph:"
        "swapWithMark"
      ];

    /* C-x shortcuts */
    "^x" = {
      "u" = "undo:"; /* C-x u        Undo */
      "k" = "performClose:"; /* C-x k        Close */
      "^f" = "openDocument:"; /* C-x C-f      Open (find file) */
      "^x" = "swapWithMark:"; /* C-x C-x      Swap with mark */
      "^m" = "selectToMark:"; /* C-x C-m      Select to mark*/
      "^s" = "saveDocument:"; /* C-x C-s      Save */
      "^w" = "saveDocumentAs:"; /* C-x C-w      Save as */
    };
  };

  targets.darwin.defaults = {
    "com.apple.desktopservices" = {
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
    "Apple Global Domain" = {
      KeyRepeat = 1;
      InitialKeyRepeat = 12;
    };
    "com.apple.dock" = {
      autohide = true;
    };
  };

  home.activation.configureTerminal = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $VERBOSE_ECHO "Importing terminal configuration"
    $DRY_RUN_CMD defaults import com.apple.Terminal ${./macos/Terminal.plist}
  '';

  home.activation.installFonts = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $VERBOSE_ECHO "Installing missing fonts"

    $VERBOSE_ECHO "Checking for IBM Plex"
    if [ ! -d ~/Library/Fonts/OpenType ]; then
        $DRY_RUN_CMD ${pkgs.curl}/bin/curl -L https://github.com/IBM/plex/releases/download/v5.1.3/OpenType.zip -o /tmp/plex.zip
        $DRY_RUN_CMD cd ~/Library/Fonts
        $DRY_RUN_CMD unzip /tmp/plex.zip
    fi

    $VERBOSE_ECHO "Checking for icon fonts"
    if [ ! -d ~/Library/Fonts/Icons ]; then
        $DRY_RUN_CMD mkdir ~/Library/Fonts/Icons
        for font in all-the-icons file-icons fontawesome material-design-icons octicons weathericons; do
           $DRY_RUN_CMD ${pkgs.curl}/bin/curl -L https://raw.githubusercontent.com/domtronn/all-the-icons.el/2f5ea7259ed104a0ef8727f640ee2525108038d5/fonts/$font.ttf -o ~/Library/Fonts/Icons/$font.ttf
        done
    fi
  '';
}
