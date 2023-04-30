# make and Makefile

My definition: `make` is a data-drive (data is in `Makefile`) filter for
building 'targets'.

GNU [man page](https://man7.org/linux/man-pages/man1/make.1.html),
[manual](https://www.gnu.org/software/make/manual/make.html),
[quick reference](https://www.gnu.org/software/make/manual/make.html#Quick-Reference).

[Tutorial](https://makefiletutorial.com/)

## Summary of automatic variables

[Manual on automatic variables](https://www.gnu.org/software/make/manual/make.html#Automatic-Variables)

Variable|Description
--------|-----------
`$@`|the target name
`$%`|the target member name, when the target is an archive member
`$<`|just the first prerequisite
`$?`|all the prerequisites newer than the target
`$^`|all the prerequisites
`.PHONY`|Adding `.PHONY` to a target will prevent `make` from confusing the phony target with a file name. [manual](https://www.gnu.org/software/make/manual/make.html#Phony-Targets), one of many [special built-in targets](https://www.gnu.org/software/make/manual/make.html#Special-Targets)

## Examples

[c-simple.mak](c-simple.mak):
```
{% include_relative c-simple.mak %}
```

[c.mak](c.mak):
```
{% include_relative c.mak %}
```

[python.mak](python.mak)
```
{% include_relative python.mak %}
```
