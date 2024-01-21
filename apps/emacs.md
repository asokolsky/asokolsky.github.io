# Emacs Cheat Sheet

* [Emacs Configuration](https://github.com/daviwil/dotfiles/blob/master/Emacs.org)
* [Emacs Wiki](https://www.emacswiki.org/)
* [GNU Emacs Manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/)

## Concepts

* [buffer](https://www.gnu.org/software/emacs/manual/html_node/emacs/Buffers.html)
* [window](https://www.gnu.org/software/emacs/manual/html_node/emacs/Basic-Window.html)
* [kill](https://www.gnu.org/software/emacs/manual/html_node/emacs/Killing.html)
~ cut
* [yank](https://www.gnu.org/software/emacs/manual/html_node/emacs/Yanking.html)
~ paste

## Notations

Key|PC|Mac
---|--|---
[Meta](https://en.wikipedia.org/wiki/Meta_key)| Esc|⌘
[RETURN](https://en.wikipedia.org/wiki/Enter_key)|Enter|RETURN
[DEL](https://en.wikipedia.org/wiki/Delete_key)|DEL (or M-BACKSPACE on some keyboards)| DEL

Notation|Means
--------|-----
C-x|Press and hold the Control key and then press and release the “x” key
M-x|Press and release the Meta key and then press the “x” key

## Key Bindings

I usually
[swap](https://www.emacswiki.org/emacs/MovingTheCtrlKey)
[Caps Lock](https://en.wikipedia.org/wiki/Caps_Lock) and
[Control](https://en.wikipedia.org/wiki/Control_key) keys:

* [on Linux](https://www.emacswiki.org/emacs/MovingTheCtrlKey#h5o-2)
using the keyboard settings GUI
* [on MacOS](https://www.emacswiki.org/emacs/MovingTheCtrlKey#h5o-14)
using [karabiner](../macos/keyboard.html)
* [on Windows](https://www.emacswiki.org/emacs/MovingTheCtrlKey#h5o-15)
using [registry hack](../windows/SwapCapsCtrl.reg)

## Exits

Key|Command|Function
---|-------|--
C-x C-c|Exit Emacs|

[Exiting emacs](https://www.gnu.org/software/emacs/manual/html_node/emacs/Exiting.html)

## Open/Save File

Key|Command|Function
---|-------|--
C-x C-f|Open or create file|M-x find-file
C-x C-r|Open file in read-only mode|M-x find-file-read-only
C-x C-v|Replace current opened file|M-x find-alternate-file
C-x C-s|Save buffer|M-x save-buffer
C-x C-w|Save file with new name|M-x write-file
C-x i|Insert another file|M-x insert-file

Manual on:

* [Visiting file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Visiting.html)
* [Saving file](https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving.html)

## Buffers

[Buffers in manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/Buffers.html).

Key|Command|Function
---|-------|--
C-x b|Switch to another buffer|M-x switch-to-buffer
C-x C-b|List buffers|M-x list-buffer
C-x k|Kill current buffer|M-x kill-buffer
C-x C-s|Save buffer|M-x save-buffer
C-l|Refresh buffer, cycle mid, bottom, top|


## Windows

Key|Command|Function
---|-------|--
C-x 2|Split window vertically|M-x split-window-vertically
C-x 3|Split window horizontally|M-x split-window-horizontally
C-x o|Move to another window|M-x other-window
C-x 0|Delete the current window|M-x delete-window
C-x 1|Delete all windows but the current|M-x delete-other-windows
&nbsp;|**Resize Window**|
C-x -|shrink the current window to fit its content|M-x shrink-window-if-larger-than-buffer
C-x ^|increase the current window height by 1,<br>or the prefix arg value|M-x enlarge-window
C-x }|make it wider|M-x enlarge-window-horizontally
C-x {|makes it narrower|M-x shrink-window-horizontally
C-x +|make the windows the same heights and widths|M-x balance-windows

[more on this](https://www.emacswiki.org/emacs/WindowResize).

## Moving Caret Around

Move By|Forward|Backward
-------|-------|--------
Char|C-f|C-b
Word|M-f|M-b
Sentence|M-e|M-a
Paragraph|M-}|M-{
Line|C-n|C-p
Line End/Start|C-e|C-a
Buffer End/Start|M->|M-<
Scroll|C-v|M-v

Command|Keystroke|Function
-------|---------|--------
Move to the beginning of a buffer|M-<|M-x beginning-of-buffer
Move to the end of a buffer|M->|M-x end-of-buffer
Move forward one character|C-f|M-x forward-char
Move backward one character|C-b|M-x backward-char
Move down one line|C-n|M-x next-line
Move up on line|C-p|M-x previous-line
Move forward one word|M-f|M-x forward-word
Move backward one word|M-b|M-x backward-word
Move to the end of a line|C-e|M-x end-of-line
Move to the beginning of a line|C-a|M-x beginning-of-line
Move forward one screen|C-v|M-x scroll up
Move backward one screen|M-v|M-x scroll-down

## Deleting Text

Command|Keystroke|Function
-------|---------|--------
Delete character|C-d|M-x delete-char
Delete previous character|DEL|M-x delete-backward-char

## Kill / Yank

Command|Keystroke|Function
-------|---------|--------
Kill word|M-d|M-x kill-word
Kill previous word|M-DEL|M-x backward-kill-word
Kill the entire line|C-k|M-x kill-line
Kill the marked region|C-w|M-x kill-region
Copy a marked region|M-w or C-INSERT|M-x kill-ring-save
Yank the region|C-y|M-x yank
Yank the rectangle|C-x r y|M-x yank-rectangle

### Mark Text to Kill / Yank

Command|Keystroke|Function
-------|---------|--------
Mark the beginning of a selection|C-@ or C-SPACEBAR|M-x set-mark-command

### Rectangles

[Rectangles are supported](https://www.gnu.org/software/emacs/manual/html_node/emacs/Rectangles.html).

Command|Keystroke|Function
-------|---------|--------
Toggle Rectangle Mark mode|C-x SPC|M-x rectangle-mark-mode
Kill the region-rectangle|C-x r k|M-x kill-rectangle
Yank the last killed rectangle|C-x r y|M-x yank-rectangle
Clear the region-rectangle|C-x r c|M-x clear-rectangle


## Incremental Search

Command|Keystroke|Function
-------|---------|--------
Forward|C-s|M-x isearch-forward
Backward| C-r|M-x isearch-backward
Exit|ENTER or RETURN|
Cancel|C-g|M-x keyboard-quit
Delete incorrect character in search string|DEL|

[Incremental search in manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/Incremental-Search.html).

## Search / Replace Text

Command|Keystroke|Function
-------|---------|--------
Search forward|C-s RETURN|
Search backward|C-r RETURN|
Start search and replace|M-%|M-x query-replace
Replace current instance and continue on to next instance|SPACEBAR or y|
Don not replace current instance, move on to next instance|DEL|
Replace the current instance and then quit|. (period key)|
Replace the current instance and then pause|, (comma key)|
Resume after pausing|SPACEBAR or y|
Replace remaining instances without asking| !|
Back up to previous instance|^|
Exit query replace|RETURN (or ENTER on some keyboards) or q|

## Wildcard Search

Command|Keystroke|Function
-------|---------|--------
Search forward|M C-s RETURN FOLLOWED BY thisIsMySearchExpressio*|M-x re-search-forward
Search backward|M C-r RETURN FOLLOWED BY thisIsMySearchExpressio*|M-x re-search-backward
Search forward and incrementally|M C-s|M-x isearch-forward-regexp
Search backward and incrementally|M C-r|M-x isearch-backward-regexp

## Dired

Command|Keystroke|Function
-------|---------|--------
Dired|C-x d *.*|M-x dired
Dired|C-x C-f|M-x find-file
Dired on the default-directory|C-x C-j|M-x dired-jump
Dired in another window|C-x 4 d|M-x dired-other-window
Dired in a separate frame|C-x 5 d|M-x dired-other-frame

[Dired in manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html)

## Interactive SubShell

Command|Keystroke|Function
-------|---------|--------
Shell||M-x shell

[interactive subshell in manual](https://www.gnu.org/software/emacs/manual/html_node/emacs/Interactive-Shell.html)

## Misc Commands

Command|Keystroke|Function
-------|---------|--------
Undo|C-x u|
Undo all changes since the last save|| M-x revert-buffer
Cancel current command|C-g|

## Color Theme

Must have [Color Theme](./color-themes.html), e.g.
[Dracula](https://draculatheme.com/emacs)!
