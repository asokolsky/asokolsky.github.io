# zsh

Must read [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

Config

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
{% include_relative dot-files/zshenv %}
```
### .zprofile

```sh
{% include_relative dot-files/zprofile %}
```

### .zshrc

```sh
{% include_relative dot-files/zshrc %}
```

## zsh/bash tips

[here document](https://www.howtogeek.com/719058/how-to-use-here-documents-in-bash-on-linux/)

```sh
cat << EOF > session.txt
Your user name is: $(whoami)
Your current working directory is: $PWD
Your Bash version is: $ZSH_VERSION
EOF
```

## Compare command output with expectations

```sh
diff -u expected.txt <(some command)
```

## bash script header

```
#!/usr/bin/env bash
# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
set -o xtrace
```

[my example use](https://gist.github.com/asokolsky4clari/9acbd78dea87f100f04623dbace33c66)
