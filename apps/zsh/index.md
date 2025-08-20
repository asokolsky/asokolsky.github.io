# ZSH

TLDR:

* install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
* in `.zshrc` set `ZSH_THEME="agnoster"` - see
[agnoster-zsh-theme](https://github.com/agnoster/agnoster-zsh-theme)
* install [powerline-fonts](https://github.com/powerline/fonts) with
`sudo apt-get install fonts-powerline`
* reboot

The rest is history.

Good read:

* [Configuring ZSH Without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/)

Check out [one-liners](one-liners.html).

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

You also set any variables that are only used in the interactive shell (e.g. $LS_COLORS).

`.zlogin` is sourced on the start of a login shell but after `.zshrc` if the shell is also interactive.  This file is often used to start X. Some systems
start X on boot, so this file is not always very useful.

### .zshenv, .zprofile, .zshrc

See [dot-files](../dot-files/)

## zsh/bash tips

[here document](https://www.howtogeek.com/719058/how-to-use-here-documents-in-bash-on-linux/)

```sh
cat << EOF > session.txt
Your user name is: $(whoami)
Your current working directory is: $PWD
Your Bash version is: $ZSH_VERSION
EOF
```

## bash script header

```sh
{% include_relative header.sh %}
```

[my example use](https://gist.github.com/asokolsky4clari/9acbd78dea87f100f04623dbace33c66)

## Shell Variables

From
[Shell-Variables](https://www.gnu.org/software/bash/manual/bash.html#Bourne-Shell-Variables):


Variable|Description
--------|----------
PPID|The process ID of the shell’s parent process.
PWD|The current working directory as set by the cd builtin.
RANDOM| Each time this parameter is referenced, it expands to a random integer between 0 and 32767.

From [Special-Parameters](https://www.gnu.org/software/bash/manual/bash.html#Special-Parameters):


Parameter|Description
---------|----------
`$*`|Positional parameters, starting from one.
`$@`|Positional parameters, starting from one.
`$#`|Number of positional parameters in decimal.
`$?`|Exit status of the most recently executed foreground pipeline.
`$$`|Process ID of the shell. In a subshell, it expands to the process ID of the invoking shell, not the subshell.
`$!`|Process ID of the job most recently placed into the background.
`$0`|Name of the shell or shell script.
`$1`..`$9`|The first 9 additional parameters the script was called with.

## Parameter Expansion

```sh
echo "${var}"
echo "Substitute the value of var."

echo "${var:-word}"
echo "If var is null or unset, word is substituted for var. The value of var does not change."

echo "${var:=word}"
echo "If var is null or unset, var is set to the value of word."

echo "${var:?message}"
echo "If var is null or unset, message is printed to standard error. This checks that variables are set correctly."

echo "${var:+word}"
echo "If var is set, word is substituted for var. The value of var does not change."
```

[More details](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html).

May combine with
[colon built-in](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-_003a)
to assign a default value to a variable, e.g.:
```sh
# TMPDIR is defined on MacOS
: "${TMPDIR:=/tmp}"
```
