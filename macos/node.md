# Node on MacOS

Node.js stack involves multiple participants...

## npm

[npm](https://nodejs.org/en/knowledge/getting-started/npm/what-is-npm/) is:

* online repo for Node.js projects
* dependency manager

E.g. to get documentation for module `n`:

```sh
npm docs n
```

Use `n` - see below - for version management.  Yet to upgrade to the latest:

```sh
sudo npm install -g npm@latest
```

## n

[n](https://github.com/tj/n) is an interactive Node.js version manager

Install it with

```sh
brew install n
```

Downgrade it:

```
$ npm install -g n
$ sudo n 16.13.2
$ sudo n
   installed : v16.13.2 (with npm 8.1.2)
$ node -v
v16.13.2
```

Typical use:

```sh
sudo n install 16.15.1
```

## yarn

[yarn](https://yarnpkg.com/), or Yet Another Resource Navigator, is a package
manager for Node.js developed by Facebook.
[yarn-vs-npm](https://www.knowledgehut.com/blog/web-development/yarn-vs-npm)


Install it:
```sh
npm install -g yarn
```
