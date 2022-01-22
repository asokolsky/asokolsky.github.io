# tmux cheatsheet

tmux is [awesome and is highly
recommended](https://www.howtogeek.com/671422/how-to-use-tmux-on-linux-and-why-its-better-than-screen/).

## Architecture

Session < Window < Pane:

* Session - for an overall theme, such as work, or experimentation, or
sysadmin, may have more than one window;
* Window - for projects within that theme, may have more than one pane;
* Pane - for view within your current project.

## Modes

Interaction modes:

* regular
* copy
* command

Task|KB
----|--
Show all shortcuts|ctrl-b ?
Enter Copy mode|ctrl-b  (
Enter Copy mode and scroll one page up|ctrl-b  PgUp
Quit Copy mode|ctrl-b q
Enter Command Mode|ctrl-b :

## Sessions

Session name is displayed (by default) in the status bar on the left, e.g. `[0]`.

Management Task|KB|CLI
----|--|---
Start a new session| |`tmux new [-s ses]`
Kill session ses| |`tmux kill-ses -t ses`
list sessions|ctrl-b s|`tmux ls`
Attach to last session| |`tmux at`
Attach to a session _ses_| |`tmux at -t ses`
rename the current session|ctrl-b  $|
detach from the current session|ctrl-b  d|

Navigation Task|KB
----|--
Move to prev|ctrl-b  (
Move to next session|ctrl-b )

### Command
`: attach -d` Detach others on the session
(Maximize window by detach other clients)

## Windows

By default, window info is displayed int he status bar on the left, e.g. `0:bash*`, where:

* `0` - window # in this session;
* `bash` - name of the process running;
* `*` - means this is the window you’re looking at.

Each time you create a new window in a tmux session, its window number and the
name of the program running in it are added to the status bar.

Management Task|KB|CLI
-|-|-
Create window _win_|ctrl-b c|`tmux new -s ses -n win`
Close current window|ctrl-b &|
Rename current window|ctrl-b ,|
List windows|ctrl-b w|
Split horizontally|ctrl-b %|
Split vertically|ctrl-b "|

Navigation Task|KB
-|-
Move to prev window|ctrl-b p
Move to next window|ctrl-b n
Switch/select window by number|ctrl-b 0…9

### Commands

`: swap-window -s 2 -t 1` Reorder window: swap window number 2(src)
and 1(dst)

`: swap-window -t -1` Move current window to the left by one position

## Panes


Management Task|KB
----|--
Split pane vertically|ctrl-b %
Split pane horizontally|ctrl-b "
Kill the current pane|ctrl-b x
Convert pane into a window|ctrl-b !
show pane numbers|ctrl-b q


Navigation Task|KB
----|--
swap with next pane|ctrl-b {
swap with previous pane|ctrl-b }
Switch to pane in that direction|ctrl-b ↑
Switch to pane in that direction|ctrl-b ↓
Switch to pane in that direction|ctrl-b ←
Switch to pane in that direction|ctrl-b →
Switch to pane|ctrl-b q 0..9
toggle between panes|ctrl-b o



Presentation Task|KB
----|--
Toggle last active pane|ctrl-b ;
Toggle between pane layouts|ctrl-b Spacebar
Toggle pane zoom|ctrl-b z
Resize current pane height, holding second key is optional|ctrl-b ctrl-↑, ctrl-b ctrl-↓
Resize current pane width, holding second key is optional|ctrl-b ctrl-←, ctrl-b ctrl-→

### Commands

`: setw synchronize-panes` Toggle synchronize-panes (send command to all panes)

## Copy Mode

KB|Task
--|----
Ctrl + b [|Enter copy mode
Ctrl + b PgUp|Enter copy mode and scroll one page up
q|Quit mode
g|Go to top line
G|Go to bottom line
↑|Scroll up
↓|Scroll down
h|Move cursor left
j|Move cursor down
k|Move cursor up
l|Move cursor right
w|Move cursor forward one word at a time
b|Move cursor backward one word at a time
/|Search forward
?|Search backward
n|Next keyword occurrence
N|Previous keyword occurrence
Spacebar|Start selection
Esc|Clear selection
Enter|Copy selection
Ctrl + b ]|Paste contents of buffer_0

## Misc Commands

`: setw -g mode-keys vi` Use vi keys in buffer

`: setw -g OPTION` Set OPTION for all windows

`: show-buffer` Display buffer_0 contents

`: capture-pane` Copy entire visible contents of pane to a buffer

`: list-buffers` Show all buffers

`: choose-buffer` Show all buffers and paste selected

`: save-buffer buf.txt` Save buffer contents to `buf.txt`

`: delete-buffer -b 1` Delete buffer_1

`: set -g OPTION` Set OPTION for all sessions

## Misc CLI

`$ tmux info` Show every session, window, pane, etc...
