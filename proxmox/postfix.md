# Configure Postfix to Forward e-mail

## Source

[Configure postfix to use gmail as a mail
relay](https://www.howtoforge.com/tutorial/configure-postfix-to-use-gmail-as-a-mail-relay/).

## Extra Step

```
% apt install libsasl2-modules
```

## Config

Disable IPv6 in /etc/postfix/main.cf:

```
# See /usr/share/postfix/main.cf.dist for a commented, more complete version

myhostname=fuji.lan

smtpd_banner = $myhostname ESMTP $mail_name (Debian/GNU)
biff = no

# appending .domain is the MUA's job.
append_dot_mydomain = no

# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h

alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
mydestination = $myhostname, localhost.$mydomain, localhost

#####
relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_security_options =
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

mynetworks = 127.0.0.0/8
inet_interfaces = loopback-only
inet_protocols = ipv4
recipient_delimiter = +

compatibility_level = 2
```

Create /etc/postfix/sasl_passwd

```
[smtp.gmail.com]:587    username@gmail.com:password
```

Then create /etc/postfix/sasl_passwd.db

```
% chmod 600 /etc/postfix/sasl_passwd
% postmap /etc/postfix/sasl_passwd
```

## Restart Postfix

```
% systemctl restart postfix.service
```

## Test

```
# ls -la >/tmp/crap
# mail -s "test" asokolsky@yahoo.com < /tmp/crap
```

Then check output of:
```
# journalctl
```
