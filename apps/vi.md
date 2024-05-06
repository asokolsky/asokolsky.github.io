# vi(m) cheat sheet

[wiki on vi](https://en.wikipedia.org/wiki/Vi),
the [original article](https://docs.freebsd.org/44doc/usd/12.vi/paper.html).

## Command Line

Command|Action
-------|------
vi _file_|edit _file_
view _file_|view _file_
vi -r _file_|view _file_
vi -R _file_|view _file_
vi + _file_|edit _file_, cursor at last line
vi +_n_ _file_|edit _file_, cursor at line _n_

## Modes: Command & Input

vi starts in _command mode_. Navigation commands operate in _command mode_.
To switch to _input mode_ enter one of the input commands.
Once in _input mode_, any character you type is added to the file.
To exit the _input mode_, press the Esc key.

```mermaid
graph LR
    A[Start] --> B(Command Mode)
    B -- Navigation --> B
    B -- Deletion --> B
    B -- Input Command --> D(Input Mode)
    B -- Visual Command --> E(Visual Mode)
    D --Esc--> B
    E --Esc--> B
```

see also
[vim transition diagram](https://gist.githubusercontent.com/darcyparker/1886716/raw/c1ee7657010278a787c6502b796a6766a40d56aa/vimModeStateDiagram.svg).

## File Open

Key|Action
---|------
:e _file_|Open _file_ for editing
:e! _file_|Discard changes, open _file_ for editing

## Save, Exit

While in command mode...

Key|Action
---|------
:x|Save and exit
:q|Quit
:q!|Discard changes, quit
:e!|Discard changes since last save
:w|Save
:w!|Save, overwrite protection
:w _file_|Save as _file_
:wq|Save the file, exit vi

## Navigation

While in Command Mode...

Key|Action
---|------
H|Upper left corner (home)
M|Middle line
L|Lower left corner
h|Back a character
l|Forward a character
&nbsp;|**Word navigation**
w|One word forward
b|One word back
&nbsp;|**Line navigation**
^|Beginning of line
$|End of line
j|Down a line
k|Up a line
G|go to the last line
1 G|go to the first line
 _n_ G|go to line _n_
: _n_|go to line _n_
Ctrl+G|display line
&nbsp;|**Viewport navigation**
z [Enter]|Cursor at top
z.|Cursor in the middle
z-|Cursor at bottom

## Search & Replace

Searches are case sensitive by default.

Search case sensitivity|Command
-----------------------|--------
Ignore case|:set ic
Respect case|:set noic

Special characters in search pattern:

Character|Matching
---------|--------
^|Beginning of line
$|End of line
\\<|Beginning of word
\\>|End of word
.|Wildcard characters

Key|Action
---|------
fc|Find c
;|Repeat find (find next c)
/ _pattern_ |Forward
/ |Repeat forward
? _pattern_|Reverse
? |Repeat reverse
n|Next occurrence in the direction of search
N|Prev occurrence in the direction of search
:g/_from_/s//_to_/g|Global replace
:g/_from_/s//_to_/g|Global replace, consult

## Deletion Commands

While in command mode...

Key|Action
---|------
dd|Delete a line
_n_ dd|Delete n lines
d)|Delete to end of sentence
db|Delete the previous word
D|Delete to the end of line
x|Delete a character

## Undo commands

Key|Action
---|------
u|Undo last change
U|Undo all changes on line

## Input Commands

These force transition to input mode.
To get back into command mode, press Esc.

Key|Action
---|------
i|Insert before
a|Insert after
I|Insert at the beginning of line
A|Insert at the end of line
o|Open line below
O|Open line above
:r _file_|Import a file
:12r _file_|Import a file at line 12

## Visual Commands

Key|Action
---|------
v|begins regular visual mode, and works similar to selecting text with a mouse. Use `h` and `l` to expand the selection left and right to include more words, and use `j` and `k` to expand the selection to the lines below and above.
V|begins linewise visual mode. This selects entire lines of text at a time. Use `j` and `k` to expand the selection up and down.
Ctrl+v|enters block visual mode. This selects text in a block format, allowing to select parts of multiple lines without including the entire line. Use `h`, `j`, `k`, `l` as usual.

Once the selection is done, use:

Key|Action
---|------
Esc|exit visual mode
d|delete the text
y|yank (copy) the text
p|paste your clipboard onto the text, replacing it
c|change the text, which deletes it and sets your cursor for typing
r|replace the text with the next character you type
`y`, `q`, `/`, `p`|search for the text elsewhere in your document
`>`|indent the text, removes selection
`<`|unindent the selection, removes selection
