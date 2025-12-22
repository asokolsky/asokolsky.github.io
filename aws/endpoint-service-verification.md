# Endpoint Service DNS Verification

https://docs.aws.amazon.com/vpc/latest/privatelink/manage-dns-names.html

In the [Endpoint Services](https://us-east-1.console.aws.amazon.com/vpcconsole/home?region=us-east-1#EndpointServices:tag:Name=dh-diag-steelix)
Console GUI select your service then:

Actions/Verify domain ownership for private DNS name

Then follow the prompt and create a TXT record:

In AWS Console select: Route 53 / Hosted zones / (private) prestaging.company.io

Domain verification name

_lvkl5bv0sifyinyqqfm0
Domain verification value

vpce:3ABP7H3z1B1sxpY0Bwel
