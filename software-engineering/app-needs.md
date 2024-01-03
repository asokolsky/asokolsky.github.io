# What an App Needs

Let's have a look at the needs of a common app, say, `foo-bar`, and how these
needs are met in:

* bare OS (Linux) environment
* container
* k8s

## App Needs and Wants

An app typically has:

* binaries
* configuration
* secrets
* logs
* exposes means to control its lifecycle


## Bare OS (Linux) Environment

The guiding design principles here are:

* [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard),
[latest version](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html).
* howto force an app to reread its settings?
* if an app is a service....

See the
[/opt vs /usr/local debate](https://www.linuxjournal.com/magazine/pointcounterpoint-opt-vs-usrlocal)


### Configuration

Candidates:

* [/etc/opt/foo-app](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch03s07.html#etcoptConfigurationFilesForOpt)
