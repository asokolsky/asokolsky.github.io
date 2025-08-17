# make - lessons learned

## PROS

* declarative paradigm works

## CONS

* reliance on a whitespace char (tab) to express semantics (target steps?) is major challenge.  Here is an excuse:

    Lines starting with a tab are interpreted as shell commands, part of a "recipe", and are passed directly to the shell for execution. Lines not starting with a tab are interpreted as Makefile syntax, such as directives for make itself (e.g., ifeq, endif), variable assignments, etc.

From [The UNIX-HATERS Handbook](https://en.wikipedia.org/wiki/The_UNIX-HATERS_Handbook):

    While make’s model is quite general, the designers forgot to make it easy to use for common cases. In fact, very few novice Unix programmers know exactly how utterly easy it is to screw yourself to a wall with make, until they do it.
