# Install Java on Mac

You should have brew installed.

1. Install OpenJDK:

```sh
brew tap AdoptOpenJDK/openjdk
brew install --cask adoptopenjdk8
```

2. Install [jenv](https://github.com/jenv/jenv):

```sh
brew install jenv
```

3. Add the installed Java to jenv:

```sh
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
jenv global 1.8
```

4. Update your .zshrc

```sh
# set up jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# From https://github.com/jenv/jenv/issues/44
export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"
alias jenv_set_java_home='export JAVA_HOME="$HOME/.jenv/versions/`jenv version-name`"'

# call function on boot to set the JAVA_HOME var on every terminal startup
jenv_set_java_home
```

You should be good to go:

```sh
java -version
```

[Fine tune](../java-vm.html) your Java VM install.
