## Cloud Init

[James Nugent](https://jen20.dev/page/about/) -
[CloudInit: The Good Parts](https://www.youtube.com/watch?v=2_m6EUo6VOI)

Docs:

* [All](https://cloudinit.readthedocs.io/en/latest/)
* [CLI](https://cloudinit.readthedocs.io/en/latest/topics/cli.html)
* [AWS data source](https://cloudinit.readthedocs.io/en/latest/topics/datasources/ec2.html)
* [FAQ](https://cloudinit.readthedocs.io/en/latest/topics/faq.htmlS)
* [Cloud-Init Configuration Merging](https://jen20.dev/post/cloudinit-configuration-merging/)

Also:

* https://medium.com/awesome-cloud/aws-difference-between-secrets-manager-and-parameter-store-systems-manager-f02686604eae
* https://docs.gomplate.ca/datasources/#using-aws-smp-datasources


## bash tips

More [bash tips](https://ricma.co/posts/tech/tutorials/bash-tip-tricks/).

Start with

```sh
set -o errexit; set -o pipefail; set -o nounset
set -x # enable xtrace
#set +x # disable xtrace
```

Use [shellcheck](https://www.shellcheck.net/wiki/Home).

## Cloud Init Run Phases:

* Init
* Config
* Final

## Files

https://cloudinit.readthedocs.io/en/latest/topics/faq.html
