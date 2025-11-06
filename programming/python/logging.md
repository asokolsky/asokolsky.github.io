# Logging in Python

From
https://realpython.com/python-logging/

## Logging to a File

save your logs in an `app.log` file
```
import logging
logging.basicConfig(
    filename="app.log",
    encoding="utf-8",
    filemode="a",
    format="{asctime} - {levelname} - {message}",
    style="{",
    datefmt="%Y-%m-%d %H:%M",
)
logging.warning("Save me!")
```

## Displaying Variable Data

use [self-documenting expressions](https://realpython.com/python-f-strings/#self-documenting-expressions-for-debugging):
```
name = "Samara"
logging.debug(f"{name=}")
```

To avoid extra evaluation, use the modulo operator (%) for interpolation instead of f-strings"
```
name = "Samara"
logging.debug("name=%s", name)
```

## Capturing Stack Traces

```
donuts = 5
guests = 0
try:
    donuts_per_guest = donuts / guests
except ZeroDivisionError:
    logging.error("DonutCalculationError", exc_info=True)
```
better yet:
```
try:
    donuts_per_guest = donuts / guests
except ZeroDivisionError:
    logging.exception("DonutCalculationError")
```

## Creating a Custom Logger

Recommended.

Instantiate:
```
import logging
logger = logging.getLogger(__name__)
```

Use multiple handlers (with custom levels) to send log to console AND file:
```
import logging
logger = logging.getLogger(__name__)
logger.setLevel("DEBUG")
console_handler = logging.StreamHandler()
console_handler.setLevel("DEBUG")
logger.addHandler(console_handler)
file_handler = logging.FileHandler("app.log", mode="a", encoding="utf-8")
file_handler.setLevel("WARNING")
logger.addHandler(file_handler)
# show all the logger handlers:
logger.handlers
```
