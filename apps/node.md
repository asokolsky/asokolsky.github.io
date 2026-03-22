# node

On MacOS `brew install node` works well enough.

On Linux `apt install node` installs a version which is hopelessly obsolete.

Therefore the plan is to:

1. install node version manager `n` with
```sh
sudo npm install -g n
```
2. use `n` to install `node`. To install `node` into `/usr/local`:
```sh
sudo n stable
```
To install node into a user-specific location:
```sh
mkdir ~/n
export N_PREFIX=$HOME/n
export PATH="$N_PREFIX/bin:$PATH"
# Make these permanent by adding to your ~/.zshrc
n stable
```

Verify node installation:

```sh
node --version
```
