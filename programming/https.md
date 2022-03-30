# Server and Client-side Certificates for Python Programmer

## HTTP Client to HTTP Server

This is well understood.

## HTTPS Client to HTTPS Server

HTTPS Server certificate includes:

* Which certificate authority issued it
* The domain name that the certificate was issued for
* Expiration date
* The public key (the private key is kept secret)

More reading:

* [what is an ssl
certificate](https://www.cloudflare.com/learning/ssl/what-is-an-ssl-certificate/);
* [what happens in a tls
handshake](https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/).

Python code to establish HTTS connection with a server,
which relies on a custom CA:

```
ses = requests.Session()
ses.verify = '/path/to/CAs'
r = ses.get( 'https://server', verify=False )
```
More on [ssl certificate
verification](https://requests.readthedocs.io/en/master/user/advanced/#ssl-cert-verification).


## HTTPS Client with a Certificate to HTTPS Server

Need to associate a client certificate AND a private key
with a session:

```
ses = requests.Session()
ses.verify = '/path/to/CAs'
ses.cert = '/path/client.cert'
r = ses.get( 'https://server', verify=False )
```
