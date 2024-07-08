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

## Development

* [Python project Makefile](/apps/make/python.mak)
* Example of
[Docker-ising your python app](https://github.com/asokolsky/pycrawl)

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

## One-liners

### URL-decode CLI

```
echo -n "%21%20" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
```
