---
title: HTML Debugging Workflow for GitHub Pages
tags: HTML,github
---

1. Point you browser to the (github pages) page to debug.
1. In firefox select File Save As..., pick the name, press Save. This will save the HTML and its dependencies into the local directory.
1. Start serving the pages saved using the python web server:
```
alex@exi | ~/tt > python3 -m http.server -h
usage: server.py [-h] [--cgi] [-b ADDRESS] [-d DIRECTORY] [-p VERSION] [port]

positional arguments:
  port                  bind to this port (default: 8000)

options:
  -h, --help            show this help message and exit
  --cgi                 run as CGI server
  -b ADDRESS, --bind ADDRESS
                        bind to this address (default: all interfaces)
  -d DIRECTORY, --directory DIRECTORY
                        serve this directory (default: current directory)
  -p VERSION, --protocol VERSION
                        conform to this HTTP version (default: HTTP/1.0)
```