# Python Programming

* [Color your console output](color-console.html)
* [Better (String) Enum in Python](python-string-enum.html),
[color.py](color.py)
* [Virtual Environment using pyenv](pyenv-virtualenv.html)
* [Server- and Client-side Certificates for Python Programmer](https.html)
* Design patters examples: [singleton](global_logger.py),
[pre-bound method](prebound_method_pattern.py), [sentinel](sentinel.py)
* Cheat sheet:
[F-Strings Number Formatting](https://cheatography.com/brianallan/cheat-sheets/python-f-strings-number-formatting/)
* [Handling relative imports](https://iq-inc.com/importerror-attempted-relative-import/)
* [5 Ways to Measure Execution Time in Python](https://superfastpython.com/benchmark-execution-time/)
* [python packages: src layout vs flat layout](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/)

## Development

* [Python project Makefile](/apps/make/python.mak)
* Example of
[Docker-using your python app](https://github.com/asokolsky/pycrawl)
* Example of a [systemd service using python venv](/proxmox/lxc-prusalink.html)

## Frameworks

* [FastAPI](fastapi.html)
* [Gaming](gaming.html)
* [hypothesis: property-based testing](https://hypothesis.works/)

To look further:

* [Textual](https://www.textualize.io/) and
[textualize/rich](https://github.com/Textualize/rich)
* [jmespath.py](https://github.com/jmespath/jmespath.py) to support query just
like aws cli does.

## External resources

* [Google style guide](https://google.github.io/styleguide/pyguide.html)
* [Guide to Python project management and packaging](https://reinforcedknowledge.com/a-comprehensive-guide-to-python-project-management-and-packaging-concepts-illustrated-with-uv-part-i/)
* [Python Closures](https://realpython.com/python-closure/)
* [Alternatives to named tuples](https://snarky.ca/dont-use-named-tuples-in-new-apis/)

## Modules of Interest

### site

[site module](https://pymotw.com/2/site/)

```
> python3 -m site
sys.path = [
    '/home/alex/Projects/asokolsky.github.io',
    '/usr/lib/python312.zip',
    '/usr/lib/python3.12',
    '/usr/lib/python3.12/lib-dynload',
    '/usr/local/lib/python3.12/dist-packages',
    '/usr/lib/python3/dist-packages',
]
USER_BASE: '/home/alex/.local' (exists)
USER_SITE: '/home/alex/.local/lib/python3.12/site-packages' (doesn't exist)
ENABLE_USER_SITE: True
```
[more details](https://pymotw.com/3/site/index.html)

### http.server

[Python's http.server module](https://www.pythonmorsels.com/http-server/),
[http.server module](https://pymotw.com/3/http.server/index.html)

```sh
python -m http.server
```

### Python 3 Module of the Week

https://pymotw.com/3/

## One-liners

### URL-decode CLI

```sh
echo -n "%21%20" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
```
