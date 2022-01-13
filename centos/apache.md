# Apache on CENTOS

# Apache Install

```
sudo yum install httpd
```

## Apache Customization

To start service:
```
sudo systemctl start httpd
```

To ensure httpd starts on power-up:
```
sudo systemctl enable httpd
```

Check status:
```
sudo systemctl status httpd
```

Modify firewal to allow for incoming HTTP and HTTPS:
```
sudo firewall-cmd ––permanent ––add-port=80/tcp
sudo firewall-cmd ––permanent ––add-port=443/tcp
sudo firewall-cmd ––reload
```

Each virtual host has a separate conf file in /etc/httpd/conf.d/.
Logs are in /var/www/html in a separate folders.

More:
https://phoenixnap.com/kb/install-apache-on-centos-7

https://www.tecmint.com/monitor-apache-web-server-load-and-page-statistics/

After reconfig do not forget:
```
httpd -t
sudo systemctl restart httpd
```
Apache status:
http://localhost/server-status?refresh=2

https://www.tecmint.com/monitor-apache-web-server-load-and-page-statistics/

Apache performance optimization:
http://httpd.apache.org/docs/current/misc/perf-tuning.html

https://serverfault.com/questions/383526/how-do-i-select-which-apache-mpm-to-use

To gracefully restart Apache:
```
apache2ctl -k graceful
```
