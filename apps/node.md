# node

`brew install node` works well enough.

`apt install node` installs a version which is obsolete.

Therefore the plan is to install node version manager and then use it to install
node.

```sh
sudo npm install -g n
sudo n stable
```

Verify it:

```sh
node --version
```
