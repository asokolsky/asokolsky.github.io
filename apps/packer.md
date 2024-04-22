# Packer

## Config File (Deprecated)

[config-file-deprecated](https://developer.hashicorp.com/packer/docs/configure#packer-s-config-file-deprecated)

## Config Directory

[Config directory](https://developer.hashicorp.com/packer/docs/configure#packer-s-config-directory) is defined in `$PACKER_CONFIG_DIR`,
defaults to `${HOME}/.config/packer/`.

## Plugin Directory

[Plugins are loaded from](https://developer.hashicorp.com/packer/docs/configure#packer-s-plugin-directory):

1. Directories under the `$PACKER_PLUGIN_PATH`, if set, no other directories'
are checked.
2. The directory where packer is installed, or the executable directory.
3. The current working directory, where packer build is being invoked. (".")
4. The `$PACKER_CONFIG_DIR/plugins` directory. `$PACKER_CONFIG_DIR` refers to Packer's config directory, if it could be found.

## Environment Variables

Packer uses a variety of environmental variables. A listing and description of each can be found below:

Environment Var|Defaults|Description
---------------|--------|-----------
`PACKER_CACHE_DIR`|`~/.cache/packer`|The location of the Packer cache. Relative paths can be used. Some plugins can cache large files like ISOs in the cache dir.
`PACKER_CONFIG`|`~/.packerconfig`|Obsolete. The location of the core configuration file. The format of the configuration file is basic JSON. See [Config file](https://developer.hashicorp.com/packer/docs/configure#packer-s-config-file).
`PACKER_CONFIG_DIR`|`~/.config/packer/`|The location for the home directory of Packer. See [Packer's home directory](https://developer.hashicorp.com/packer/docs/configure#packer-s-home-directory).
`PACKER_GITHUB_API_TOKEN`||When using Packer init on HCL2 templates, Packer queries the public API from Github which limits the amount of queries on can set the PACKER_GITHUB_API_TOKEN with a Github Token to make it higher.
`PACKER_LOG`|0|Setting this to any value other than "" (empty string) or "0" will enable the logger. See the [debugging page](https://developer.hashicorp.com/packer/docs/debugging).
`PACKER_LOG_PATH`||The location of the log file. Must be set for any logging to occur.
`PACKER_NO_COLOR`||Setting this to any value will disable color in the terminal.
`PACKER_PLUGIN_MAX_PORT`|25000|The max port that Packer uses for communication with plugins, since plugin communication happens over TCP connections on your local host.
`PACKER_PLUGIN_MIN_PORT`|10000|The minimum port that Packer uses for communication with plugins, since plugin communication happens over TCP connections on your local host.
`PACKER_PLUGIN_PATH`||e.g. `~/custom-dir-1:~/custom-dir-2`. Separate directories in the PATH string using a colon (:) on POSIX systems and a semicolon (;) on Windows systems.
`CHECKPOINT_DISABLE`||When Packer is invoked it sometimes calls out to checkpoint.hashicorp.com to look for new versions of Packer. If you want to disable this for security or privacy reasons, you can set this environment variable to 1.
`TMPDIR`|`/tmp`|The location of for the temporary files. May be necessary to customize when working with large files since `/tmp` is a memory-backed in some distributions, in which case `/var/tmp` might be preferred.

## Commands

[CLI Commands](https://developer.hashicorp.com/packer/docs/commands)

## See Also

[Packer Makefile](./make/packer.mak)
