# Chef


## Upload the cookbook

From the bastion:

```sh
knife cookbook upload <insert cookbook name> -d
```

## Troubleshooting the cookbook run

On the ec2 instance:
```sh
sudo chef-client -j /etc/chef/init.json
```

Troubleshooting steps:

* Failure can be confirmed by ssh'ing into bastion and running:
```sh
knife node list | grep <instance_id>
```
* once in the node, run
```sh
sudo chef-client -j /etc/chef/init.json
```
to pull the latest configuration/cookbook. Troubleshoot the error that comes up in the stacktrace when the `chef-client` runs and fix it to resolve the chef-client failure.

Alternatively:
```sh
sudo tail /var/log/chef/client.log
```

## Chef Commands

To list the nodes:

```sh
knife node list
```

To display details of one node:

```sh
knife node show _node_name_
```

## Chef Server Status

```sh
knife status
```

## Chef Data Bags

```sh
knife data bag list
```

```sh
knife data bag show _bag_name_
```
