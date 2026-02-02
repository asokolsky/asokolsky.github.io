# Troubleshooting Mongo

From the local log files you also see the progress, see this example:

```sh
tail -f /var/log/mongodb/mongodb.log | grep Repl
```

## Direct connection using curl

from a [community post](https://community.splunk.com/t5/Knowledge-Management/Is-it-possible-to-connect-directly-to-MongoDB/m-p/238096):

Normal spl based kv lookup query:
```
inputlookup summary where LastUpdateTime<1468532752
```

Mongodb query format [reference](https://docs.mongodb.com/manual/reference/operator/query/lt/).

```json
{"LastUpdateTime": {"$lt": 1468532752}}
```

Curl command [url encoded](http://meyerweb.com/eric/tools/dencoder/)

```sh
curl -k -u admin:changeme -X DELETE https://localhost:8089/servicesNS/nobody/myapp/storage/collections/data/summary?query=%7B%22LastUpdateTime%22%3A%20%7B%22%24lt%22%3A%201468532752%7D%7D
```
