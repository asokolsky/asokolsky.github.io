# Linux Dot Files

Approaches to managing dot files:

* [Use git for dot files](https://www.atlassian.com/git/tutorials/dotfiles)
* Use [GNU Stow](https://www.gnu.org/software/stow/)
[for dot files](https://dev.to/spacerockmedia/how-i-manage-my-dotfiles-using-gnu-stow-4l59)

## .nanorc

```
{% include_relative nanorc %}
```

## zsh startup

`.zshenv` → [`.zprofile` if login] → [`.zshrc` if interactive] → [`.zlogin` if login] → [`.zlogout` sometimes]


`.zshenv` is always sourced.  It contains exported variables that should be
available to other programs, e.g. `$PATH`, `$EDITOR`, `$PAGER`.

`.zprofile` is the same as `.zlogin` except that it's sourced before `.zshrc`
while `.zlogin` is sourced after .zshrc.  According to the zsh documentation:

> .zprofile is meant as an alternative to .zlogin for ksh fans;
> the two are not intended to be used together,
> although this could certainly be done if desired.

`.zshrc` is for interactive shell configuration:

* set options for the interactive shell with the `setopt` and `unsetopt` commands
* load shell modules
* set history options
* change prompt
* set up zle and completion, etc.
* set any variables that are only used in the interactive shell (e.g.
`$LS_COLORS`).

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

## More

* [jaybocc2/dotfiles](https://github.com/jaybocc2/dotfiles)
* [dwt1/dotfiles](https://gitlab.com/dwt1/dotfiles)
* [daviwil/dotfiles](https://github.com/daviwil/dotfiles)
* [notthebee/dotfiles](https://github.com/notthebee/dotfiles)
