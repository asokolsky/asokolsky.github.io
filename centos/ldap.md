# LDAP Setup

Before you begin make sure sure the server where LDAP will be installed has a DNS domain name assigned, 
usually localdomain on home LAN.  I used domain local.
Verify by pinging a host by a FQDN, e.g. 
```
ping fuji.local
```
## 389 Server Installation

I used 
[Fedora 389 server](https://en.wikipedia.org/wiki/389_Directory_Server)
and followed 
[these instructions](https://webhostinggeeks.com/howto/setup-389-directory-server-on-centos-7/).
Once the server is running, you should be able to access
389® Administration Express at http://host:9830/dist/download

By the end you should have these services running:
```
[alex@centos7 ~]$ systemctl status dirsrv-admin
● dirsrv-admin.service - 389 Administration Server.
   Loaded: loaded (/usr/lib/systemd/system/dirsrv-admin.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-09-30 21:25:12 EDT; 19h ago
  Process: 1649 ExecStart=/usr/sbin/httpd -k start -f /etc/dirsrv/admin-serv/httpd.conf (code=exited, status=0/SUCCESS)
 Main PID: 1650 (httpd)
   CGroup: /system.slice/dirsrv-admin.service
           ├─1650 /usr/sbin/httpd -k start -f /etc/dirsrv/admin-serv/httpd.conf
           ├─1651 /usr/sbin/httpd -k start -f /etc/dirsrv/admin-serv/httpd.conf
           └─1652 /usr/sbin/httpd -k start -f /etc/dirsrv/admin-serv/httpd.conf

Sep 30 21:25:11 centos7.local systemd[1]: Starting 389 Administration Server....
Sep 30 21:25:12 centos7.local systemd[1]: Can't open PID file /var/run/dirsrv/admin-serv.pid (yet?) after start: No such file or directory
Sep 30 21:25:12 centos7.local systemd[1]: Started 389 Administration Server..
[alex@centos7 ~]$ systemctl status dirsrv@centos7
● dirsrv@centos7.service - 389 Directory Server centos7.
   Loaded: loaded (/usr/lib/systemd/system/dirsrv@.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2020-09-30 21:25:11 EDT; 19h ago
  Process: 879 ExecStartPre=/usr/sbin/ds_systemd_ask_password_acl /etc/dirsrv/slapd-%i/dse.ldif (code=exited, status=0/SUCCESS)
 Main PID: 902 (ns-slapd)
   Status: "slapd started: Ready to process requests"
   CGroup: /system.slice/system-dirsrv.slice/dirsrv@centos7.service
           └─902 /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-centos7 -i /var/run/dirsrv/slapd-centos7.pid

Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.054475104 -0400] - NOTICE - ldbm_back_start - found 2160608k available
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.060912352 -0400] - NOTICE - ldbm_back_start - cache autosizing: db cache: 72851k
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.142657332 -0400] - NOTICE - ldbm_back_start - cache autosizing: userRoot entry cache (2 total): 131072k
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.224595208 -0400] - NOTICE - ldbm_back_start - cache autosizing: userRoot dn cache (2 total): 65536k
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.255643909 -0400] - NOTICE - ldbm_back_start - cache autosizing: NetscapeRoot entry cache (2 total): 131072k
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.266200376 -0400] - NOTICE - ldbm_back_start - cache autosizing: NetscapeRoot dn cache (2 total): 65536k
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.271207421 -0400] - NOTICE - ldbm_back_start - total cache size: 412001156 B;
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.333880699 -0400] - NOTICE - dblayer_start - Detected Disorderly Shutdown last time Directory Server was running, recovering database.
Sep 30 21:25:11 centos7.local ns-slapd[902]: [30/Sep/2020:21:25:11.601028264 -0400] - INFO - slapd_daemon - slapd started.  Listening on All Interfaces port 389 for LDAP requests
Sep 30 21:25:11 centos7.local systemd[1]: Started 389 Directory Server centos7..
[alex@centos7 ~]$
```

Check that ports 389 and 9830 are bound by the processes:
```
[root@centos7 api-umbrella]# netstat -lpn|grep 9830
tcp        0      0 0.0.0.0:9830            0.0.0.0:*               LISTEN      1650/httpd
[[root@centos7 api-umbrella]# netstat -lp|grep ldap
tcp6       0      0 [::]:ldap               [::]:*                  LISTEN      902/ns-slapd
[root@centos7 api-umbrella]# netstat -lpn|grep lap
tcp6       0      0 :::389                  :::*                    LISTEN      902/ns-slapd
```

## Certificates for CA and the server

By now we have LDAP but not LDAPS running.  
[Enable TLS now](https://directory.fedoraproject.org/docs/389ds/howto/howto-ssl.html).
[The archived version](https://directory.fedoraproject.org/docs/389ds/howto/howto-ssl-archive.html)
of the above doc is better suited for the test environment.

I followed [instructions](https://serverfault.com/questions/404742/setting-up-ssl-with-389-directory-server-for-ldap-authentication)
but failed.

Instead I followed [these](https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/):

1. Create your own certificate authority.

Generate private key:

```
alex@L07A97UF:~$ openssl genrsa -des3 -out sokolskyCA.key 2048
Generating RSA private key, 2048 bit long modulus (2 primes)
.................................................+++++
............................+++++
e is 65537 (0x010001)
Enter pass phrase for sokolskyCA.key:
Verifying - Enter pass phrase for sokolskyCA.key:
```

Generate a CA root certificate:
```
alex@L07A97UF:~$ openssl req -x509 -new -nodes -key sokolskyCA.key -sha256 -days 1825 -out sokolskyCA.pem
Enter pass phrase for sokolskyCA.key:
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:US
State or Province Name (full name) [Some-State]:California
Locality Name (eg, city) []:Campbell
Organization Name (eg, company) [Internet Widgits Pty Ltd]:HomeLAB
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:Alex Sokolsky
Email Address []:asokolsky@gmail.com
```

Install this CA using 389 console.

Install this CA into the Linux (centos7) server:
```
  /etc/pki/ca-trust/source/anchors:
  total used in directory 4 available 26388536
  drwxr-xr-x. 2 root root   29 Oct  1 19:53 .
  drwxr-xr-x. 4 root root   80 Sep 29 17:18 ..
  -rw-r--r--  1 root root 1415 Oct  1 19:53 asokolskyCA.pem
```
then
```
[root@centos7 anchors]# update-ca-trust
```

Verify that /etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt has it.

2. Create certificate signed by your CA

Create a CSR file centos7.local.csr using the 389 Console.


Create a config file ldaps.ext defining the Subject Alternative Name (SAN) extension:
```
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = dev.deliciousbrains.com
```

Next we create a certificate using:

* the certificate request centos7.local.csr
* CA private key sokolskyCA.key
* CA certificate sokolskyCA.pem
* config file ldaps.ext

```
alex@L07A97UF:~$ openssl x509 -req -in ldaps.csr -CA sokolskyCA.pem -CAkey sokolskyCA.key -CAcreateserial -out centos7.local.crt -days 825 -sha256 -extfile ldaps.ext
Signature ok
subject=C = US, ST = California, L = Campbell, O = HomeLAB, CN = centos7.local, emailAddress = asokolsky@gmail.com
Getting CA Private Key
Enter pass phrase for sokolskyCA.key:
```

Install the certificate centos7.local.crt usine the console app.

Use console app to configure directory server to use encryption using the installed certificate.

Then restart the directory server:
```
[alex@centos7 ~]$ sudo systemctl restart dirsrv@centos7
[alex@centos7 ~]$ sudo systemctl status dirsrv@centos7
● dirsrv@centos7.service - 389 Directory Server centos7.
   Loaded: loaded (/usr/lib/systemd/system/dirsrv@.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-10-01 19:25:08 EDT; 1min 19s ago
  Process: 22371 ExecStartPre=/usr/sbin/ds_systemd_ask_password_acl /etc/dirsrv/slapd-%i/dse.ldif (code=exited, status=0/SUCCESS)
 Main PID: 22377 (ns-slapd)
   Status: "slapd started: Ready to process requests"
   CGroup: /system.slice/system-dirsrv.slice/dirsrv@centos7.service
           └─22377 /usr/sbin/ns-slapd -D /etc/dirsrv/slapd-centos7 -i /var/run/dirsrv/slapd-centos7.pid

Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.018166347 -0400] - INFO - attrcrypt_cipher_init - Key for cipher AES successfully generated and stored
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.020218062 -0400] - ERR - attrcrypt_cipher_init - No symmetric key found for cipher 3DES in backend userRoot, attempting to create one...
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.024669362 -0400] - INFO - attrcrypt_cipher_init - Key for cipher 3DES successfully generated and stored
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.027581726 -0400] - ERR - attrcrypt_cipher_init - No symmetric key found for cipher AES in backend NetscapeRoot, attempting to create one...
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.032187117 -0400] - INFO - attrcrypt_cipher_init - Key for cipher AES successfully generated and stored
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.034343082 -0400] - ERR - attrcrypt_cipher_init - No symmetric key found for cipher 3DES in backend NetscapeRoot, attempting to create one...
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.039119021 -0400] - INFO - attrcrypt_cipher_init - Key for cipher 3DES successfully generated and stored
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.098767193 -0400] - INFO - slapd_daemon - slapd started.  Listening on All Interfaces port 389 for LDAP requests
Oct 01 19:25:08 centos7.local ns-slapd[22377]: [01/Oct/2020:19:25:08.108321762 -0400] - INFO - slapd_daemon - Listening on All Interfaces port 636 for LDAPS requests
Oct 01 19:25:08 centos7.local systemd[1]: Started 389 Directory Server centos7..
```

Check that LDAPS port is indeed bound:
```
[alex@centos7 ~]$ sudo netstat -lp|grep slap
tcp6       0      0 [::]:ldaps              [::]:*                  LISTEN      22377/ns-slapd
tcp6       0      0 [::]:ldap               [::]:*                  LISTEN      22377/ns-slapd
```


## 389 Server Management

[Instructions](https://www.unixmen.com/manage-389-directory-server-graphically-using-389-management-console/).

On my Windows laptop I installed Java and then
[389 Management Console](https://directory.fedoraproject.org/docs/389ds/releases/release-windows-console-1-1-15.html).

Possible alternative would be 
[ldp](https://www.active-directory-security.com/2016/06/ldp-for-active-directory-download-usage-tutorial-and-examples.html)

## Verification

Once organizational units and new users are defined, test it like this:

```
$ ldapsearch -x -b "dc=local"
```

To search for just users:
```
[root@centos7 api-umbrella]# ldapsearch -x -b "dc=local" "objectClass=person"
# extended LDIF
#
# LDAPv3
# base <dc=local> with scope subtree
# filter: objectClass=person
# requesting: ALL
#

# asokolsky, support_group, Support Division, local
dn: uid=asokolsky,cn=support_group,ou=Support Division,dc=local
mail: asokolsky@gmail.com
uid: asokolsky
givenName: Alex
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetorgperson
sn: Sokolsky
cn: Alex Sokolsky
telephoneNumber: 1-408.533.5542

# ssokolsky, support_group, Support Division, local
dn: uid=ssokolsky,cn=support_group,ou=Support Division,dc=local
mail: sonya@far.com
uid: ssokolsky
givenName: Sonya
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetorgperson
sn: Sokolsky
cn: Sonya Sokolsky

# search result
search: 2
result: 0 Success

# numResponses: 3
# numEntries: 2
```

To search for a specific username:

```
[root@centos7 api-umbrella]# ldapsearch -x -b "dc=local" "uid=asokolsky"
# extended LDIF
#
# LDAPv3
# base <dc=local> with scope subtree
# filter: uid=asokolsky
# requesting: ALL
#

# asokolsky, support_group, Support Division, local
dn: uid=asokolsky,cn=support_group,ou=Support Division,dc=local
mail: asokolsky@gmail.com
uid: asokolsky
givenName: Alex
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetorgperson
sn: Sokolsky
cn: Alex Sokolsky
telephoneNumber: 1-408.533.5542

# search result
search: 2
result: 0 Success

# numResponses: 2
# numEntries: 1

```

Finally, to test authentication against LDAP:

```
[alex@centos7 ~]$ ldapsearch -D "uid=asokolsky,dc=local" -o ldif-wrap=no -b "dc=local"  -W uid=asokolsky
Enter LDAP Password:
ldap_bind: Invalid credentials (49)
```
