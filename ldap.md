# LDAP and AD

From https://ldapwiki.com/wiki/LDAP%20Query%20Examples%20for%20AD

AD exports its fields according to a certain schema, which does not set "uid"
like the Unix ENG LDAP.

AD LDAP should be queried for sAMAccountName instead of uid:

```
% ldapsearch -h foo.bar.com -D 'foo\a.sokolsky' -W -b 'DC=foo,DC=bar,DC=com' \
    '(&(sAMAccountName=a.sokolsky)(objectClass=user))'
```

mailNickname is also set:

```
% ldapsearch -h foo.bar.com -D 'foo\a.sokolsky' -W -b 'DC=foo,DC=bar,DC=com' '(&(mailNickname=a.sokolsky)(objectClass=user))'
```
