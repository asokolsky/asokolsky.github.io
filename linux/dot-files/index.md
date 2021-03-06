# Linux Dot Files

[The best way to store your
dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)

[Jay's repo](https://github.com/jaybocc2/dotfiles)

[Another repo](https://gitlab.com/dwt1/dotfiles)

## zsh startup

`.zshenv` → [`.zprofile` if login] → [`.zshrc` if interactive] → [`.zlogin` if login] → [`.zlogout` sometimes]


`.zshenv` is always sourced.  It contains exported variables that should be
available to other programs, e.g. `$PATH`, `$EDITOR`, `$PAGER`.

`.zprofile` is the same as `.zlogin` except that it's sourced before `.zshrc`
while `.zlogin` is sourced after .zshrc.  According to the zsh documentation:

> .zprofile is meant as an alternative to .zlogin for ksh fans;
> the two are not intended to be used together,
> although this could certainly be done if desired.

`.zshrc` is for interactive shell configuration. You set options for the
interactive shell there with the setopt and unsetopt commands. You can also:

* load shell modules
* set your history options
* change your prompt
* set up zle and completion, etc.

You also set any variables that are only used in the interactive shell (e.g.
$LS_COLORS).

`.zlogin` is sourced on the start of a login shell but after `.zshrc` if the
shell is also interactive.  This file is often used to start X. Some systems
start X on boot, so this file is not always very useful.

### .zshenv

```sh
{% include_relative zshenv %}
```
### .zprofile

```sh
{% include_relative zprofile %}
```

### .zshrc

```sh
{% include_relative zshrc %}
```
