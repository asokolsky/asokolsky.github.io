# Ruby

Install [rbenv](https://github.com/rbenv/rbenv):
```sh
sudo apt install rbenv
```

Install Ruby:
```sh
$ rbenv install 2.4.1
Downloading ruby-2.4.1.tar.bz2...
-> https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.bz2
Installing ruby-2.4.1...
Installed ruby-2.4.1 to /home/alex/.rbenv/versions/2.4.1
```

Start using it:

```
rbenv global 2.4.1
```

`rbenv install -l` does not show latest versions because ruby-build is obsolete.
Therefore had to [install from github](https://github.com/rbenv/ruby-build).
Then installed latest ruby.

```sh
alex@latitude7490:~/Projects/asokolsky.github.io/linux/ > rbenv versions
  system
  2.4.1
* 3.1.1 (set by /home/alex/.rbenv/version)
alex@latitude7490:~/Projects/asokolsky.github.io/linux/ > which ruby
/home/alex/.rbenv/shims/ruby
alex@latitude7490:~/Projects/asokolsky.github.io/linux/ > gem install jekyll bundler
```

## List Available Versions

To list stable versions:
```sh
rbenv install --list
```

To list all the versions:
```sh
rbenv install --list-all
```

## Install New Version

```sh
rbenv install 3.1.0
```

Lock it for your project by defining `.ruby-version`:
```
3.0.3
```
