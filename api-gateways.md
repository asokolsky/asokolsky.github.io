# API Gateways

After creating more than one REST service, I start to wonder whether it is worth having something other than
bare NGINX in front.  Possible goals:

* throttling;
* authentication & authorization.

Let's see what's there available...

## APIGee

[APIGee](https://cloud.google.com/apigee/) was founded in 2004 and acquired by Google in 2016.
NOT open source.

## APISIX

[APISIX](https://github.com/apache/apisix) is in active development.
Stacks well against Kong performance-wise.

## API Umbrella

[API Umbrella](https://github.com/NREL/api-umbrella)

[Architecture](https://api-umbrella.readthedocs.io/en/latest/developer/architecture.html)

Does not seem to command much of a mindshare...

## AWS API Gateway

[AWS API Gateway](https://aws.amazon.com/api-gateway/) is NOT open source.

## Azure API Gateway

Microsoft [Azure API Gateway](https://azure.microsoft.com/en-us/services/api-management/)
is NOT open source but CAN be deployed on-premises.

Good read on REST though:
https://azure.microsoft.com/mediahandler/files/resourcefiles/api-design/Azure_API-Design_Guide_eBook.pdf

## Clyde IO

[ClydeIO](https://github.com/clydeio/clydeio) is built with Node.js and uses
Connect middleware for filters.  Not in active development.

## Express Gateway

[Express Gateway](https://github.com/ExpressGateway/express-gateway) is based on Node.js.
Open Source.

## Kong

[Kong](https://github.com/Kong/kong) is a dominant open source
API gateway.In active development. Based on Nginx with
[OpenRESTY](https://github.com/openresty/),
implemented in Lua + Python(?).
Has plugins to provide features such as authentication, logging, etc.  Data stores required: Cassandra or Postgres

[Kong CE vs Enterprise](https://konghq.com/subscriptions/).
Kong CE only offers admin REST APIs, but open-source
dashboards are available:

* [Konga](https://github.com/pantsel/konga)
* [Kong Dashboard](https://github.com/PGBI/kong-dashboard)

Plugins:

* [LDAP Authentication](https://docs.konghq.com/hub/kong-inc/ldap-auth/)
* [CORS](https://docs.konghq.com/hub/kong-inc/cors/)

## KrakenD

https://github.com/devopsfaith/krakend

## Tyk

[Tyk](https://github.com/TykTechnologies/tyk) is a second
major open source API gateway after Kong.
[Docs](https://tyk.io/docs/).

Datastore: MongoDB, [Redis](https://redis.io/)

Installing on [RedHat](https://tyk.io/docs/getting-started/installation/with-tyk-on-premises/redhat-rhel-centos/),
[Ubuntu](https://tyk.io/docs/getting-started/installation/with-tyk-on-premises/on-ubuntu/).

## Comparison

[How to Choose the Right API Gateway](https://www.moesif.com/blog/technical/api-gateways/How-to-Choose-The-Right-API-Gateway-For-Your-Platform-Comparison-Of-Kong-Tyk-Apigee-And-Alternatives/#summary)

[Kong vs Tyk](https://www.bbva.com/en/api-gateways-kong-vs-tyk/) -
data presented heavily disputed.

[Which API Gateway](https://www.popularowl.com/reviews/which-api-gateway/)


[API Management Platforms](https://www.predictiveanalyticstoday.com/top-api-management-platforms/)
