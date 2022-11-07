# My GIT Config

Followed [Customizing Git Configuration](https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration).

```
git config --global user.name "Alex Sokolsky"
git config --global user.email "asokolsky@gmail.com"
git config --global core.pager ''
```

## Handling an Upstream Repo

```
alex@latitude7490:~/Projects/psmqtt/ > git remote -v
origin  https://github.com/asokolsky/psmqtt.git (fetch)
origin  https://github.com/asokolsky/psmqtt.git (push)
upstream        https://github.com/eschava/psmqtt.git (fetch)
upstream        https://github.com/eschava/psmqtt.git (push)
alex@latitude7490:~/Projects/psmqtt/ > git status
On branch typing
Your branch is up to date with 'origin/typing'.

nothing to commit, working tree clean
```

Just pull from upstream:

```
alex@latitude7490:~/Projects/psmqtt/ > git pull upstream master
```
And then push
```
alex@latitude7490:~/Projects/psmqtt/ > git push
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/asokolsky/psmqtt.git
   a98ddea..52094f3  master -> master
```
