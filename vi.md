# vi cheat sheet

## Command Line

|Command|Action
|-------|------
|vi _file_|edit _file_
|view _file_|view _file_
|vi -r _file_|view _file_
|vi -R _file_|view _file_
|vi + _file_|edit _file_, cursor at last line
|vi +_n_ _file_|edit _file_, cursor at line _n_

## Save, Exit

|Key|Action
|---|------
|:x|Save and exit
|:q|Quit
|:q!|Discard changes, quit
|:e!|Discard changes since last save
|:w|Save
|:w!|Save, overwrite protection

## Open

|Key|Action
|---|------
|:e _file_|Open _file_ for editing
|:e! _file_|Discard changes, open _file_ for editing

## Modes

vi starts in _command_ mode. Navigation commands operate only
in _command_ mode. To switch to _input_ mode enter one of the input commands.
Once in _input_ mode, any character you type is added to the file. To exit
_input_ mode, press the Esc key.

## Input Commands

|Key|Action
|---|------
|a|append after cursor
|i|insert before cursor
|o|Open line below
|O|Open line above

## Navigation

|Key|Action
|---|------
|G|go to the last line
| _n_ G|go to line _n_
|: _n_|go to line _n_
|Ctrl+G|display line

## Viewport

|Key|Action
|---|------
|z [Enter]|Cursor at top
|z.|Cursor in the middle
|z-|Cursor at bottom

## Search

|Key|Action
|---|------
|/ _pattern_ |Forward
|/ |Repeat forward
|? _pattern_|Reverse
|? |Repeat reverse
|n|Next occurrence in the direction of search
|N|Prev occurrence in the direction of search

## Editing

|Key|Action
|---|------
|i|Insert before
|a|Insert after
|I|Insert at the beginning of line
|A|Insert at the end of line
