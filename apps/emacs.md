# Emacs Cheat Sheet

* [Emacs Configuration](https://github.com/daviwil/dotfiles/blob/master/Emacs.org)
* [Emacs Wiki](https://www.emacswiki.org/)

## Concepts

* buffer
* window
* kill ~ cut
* yank ~ paste

## Notations

Key|PC|Mac
---|--|---
[Meta](https://en.wikipedia.org/wiki/Meta_key)| Esc | ⌘
RETURN | Enter | RETURN
DEL | DEL (or M-BACKSPACE on some keyboards)| DEL

Notation|Means
--------|-----
C-x | Press and hold the Control key and then press and release the “x” key
M-x | Press and release the Meta key and then press the “x” key

### Key Bindings

I usually
[swap](https://www.emacswiki.org/emacs/MovingTheCtrlKey)
[Caps Lock](https://en.wikipedia.org/wiki/Caps_Lock) and
[Control](https://en.wikipedia.org/wiki/Control_key) keys:

* [on Linux](https://www.emacswiki.org/emacs/MovingTheCtrlKey#h5o-2)
using the keyboard settings GUI
* [on MacOS](https://www.emacswiki.org/emacs/MovingTheCtrlKey#h5o-14)
using [karabiner](../macos/keyboard.md)
* [on Windows](https://www.emacswiki.org/emacs/MovingTheCtrlKey#h5o-15)
using [registry hack](../windows/SwapCapsCtrl.reg)

## Exits

Key | Command | Function
----|---------|--
C-x C-c | Exit Emacs |

## Open/Save File

Key | Command | Function
----|---------|--
C-x C-f | Open or create file | M-x find-file
C-x C-r | Open file in read-only mode |
C-x C-v | Replace current opened file |
C-x C-s | Save buffer | M-x save-buffer
C-x C-w | Save file with new name | M-x write-file
C-x i | Insert another file | M-x insert-file

## Buffer Commands

Key | Command | Function
----|---------|--
C-x b | Switch to another buffer | M-x switch-to-buffer
C-x C-b | List buffers | M-x list-buffer
C-x k | Kill current buffer | M-x kill-buffer
C-x C-s | Save buffer | M-x save-buffer
C-l | Refresh buffer, cycle mid, bottom, top|

## Windows

Key | Command | Function
----|---------|--
C-x 2 |Split window vertically | M-x split-window-vertically
C-x 3 |Split window horizontally | M-x split-window-horizontally
C-x o |Move to another window | M-x other-window
C-x 0 |Delete the current window | M-x delete-window
C-x 1 |Delete all windows but the current | M-x delete-other-windows

## Moving Around

Move By | Forward | Backward
------------|---------|---------
Char | C-f | C-b
Word | M-f | M-b
Sentence | M-e | M-a
Paragraph | M-} | M-{
Line | C-n | C-p
Line End/Start | C-e | C-a
Buffer End/Start | M-> | M-<
Scroll | C-v | M-v

## Cut/Delete/Kill Text

Command | Keystroke | Function
--------|-----------|---------
Delete character | C-d | M-x delete-char
Delete previous character | DEL | M-x delete-backward-char
Delete word | M-d | M-x kill-word
Delete previous word | M-DEL | M-x backward-kill-word
Delete the entire line | C-k | M-x kill-line

## Mark Text to Delete, Move or Copy

Command | Keystroke | Function
--------|-----------|---------
Mark the beginning of a selection | C-@ or C-SPACEBAR | M-x set-mark-command
Delete the marked region | C-w | M-x kill-region
Copy a marked region | M-w or C-INSERT | M-x kill-ring-save
Yank a region | C-y | M-x yank

## Incremental Search

Command | Keystroke | Function
--------|-----------|---------
Forward | C-s | M-x isearch-forward
Backward| C-r | M-x isearch-backward
Exit | ENTER or RETURN |
Cancel | C-g | M-x keyboard-quit
Delete incorrect character in search string | DEL |

## Search / Replace Text

Command | Keystroke | Function
--------|-----------|---------
Search forward | C-s RETURN |
Search backward | C-r RETURN |
Start search and replace | M-% | M-x query-replace
Replace current instance and continue on to next instance | SPACEBAR or y|
Don not replace current instance, move on to next instance | DEL |
Replace the current instance and then quit | . (period key) |
Replace the current instance and then pause | , (comma key) |
Resume after pausing | SPACEBAR or y |
Replace remaining instances without asking |  ! |
Back up to previous instance | ^ |
Exit query replace | RETURN (or ENTER on some keyboards) or q |

## Wildcard Search

Command | Keystroke | Function
--------|-----------|---------
Search forward | M C-s RETURN FOLLOWED BY thisIsMySearchExpressio* | M-x re-search-forward
Search backward | M C-r RETURN FOLLOWED BY thisIsMySearchExpressio* | M-x re-search-backward
Search forward and incrementally | M C-s | M-x isearch-forward-regexp
Search backward and incrementally | M C-r | M-x isearch-backward-regexp

## Misc Commands

Command | Keystroke | Function
--------|-----------|---------
Undo | C-x u |
Undo all changes since the last save | | M-x revert-buffer
Shell| | M-x shell
Cancel current command | C-g |

## Color Theme

Must have [Color Theme](./color-themes.md), e.g.
[Dracula](https://draculatheme.com/emacs)!
