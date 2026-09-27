# String Enum in Python

[Bare Python enum](https://docs.python.org/3/library/enum.html) is not good
enough: Int representation may be efficient, but it is not human readable,
especially after it is serialized.

NOTE:

The color.py approach was sensible before Python 3.11, but should no longer be the preferred style:
- [`Color(str, Enum)` (line 9)](color.py:9) is now superseded by StrEnum.
- The custom [`__repr__` (line 40)](color.py:40) changes interactive/container display; it is not what enables string serialization.
- [`Color._value2member_map_` (line 38)](color.py:38) accesses a private implementation detail.
- Accepting str | Color exploits the surprising fact that string-enum members compare equal to raw strings. Prefer converting at an input boundary and using Color internally.
- Modern enum members conventionally use uppercase names: Color.RED, not Color.red.

Wouldn't it be nice to have a string enum? Multiple inheritance to the resque!

```python
{% include_relative color.py %}
```

Let's see how this works for Color user...

```console
>>> r = Color.red
>>> r == 'Red'
True
>>> r == 'red'
False
>>> r
'Red'
>>> Color.is_primary( r )
True
>>> Color.is_primary( 'Red' )
True
>>> j = { 'color': r }
>>> j
{'color': 'Red'}
>>> print( j )
{'color': 'Red'}
```

I like it much more than bare enums!

## Better auto yet...

This subject gets traction! Checkout this
[FastAPI write-up](https://fastapi-utils.davidmontague.xyz/user-guide/basics/enums/)!

## Modern sources

For ordinary application enums:

```python
from enum import StrEnum


class Color(StrEnum):
    RED = 'Red'
    GREEN = 'Green'
    BLUE = 'Blue'
    BLACK = 'Black'

    @property
    def is_dark(self) -> bool:
        return self is Color.BLACK
```

Parse external input explicitly:
```python
color = Color(raw_value)  # raises ValueError for unknown input
```

The [`PersistedEnum` (line 30)](https://github.com/asokolsky/agent-orchestra/blob/main/src/agent_orchestra/persisted_enum.py:30) style is stronger when values are written to evidence, databases, or files:
- [`values()` (line 33)](https://github.com/asokolsky/agent-orchestra/blob/main/src/agent_orchestra/persisted_enum.py:33) derives validation data from the members.
- [`decode()` (line 39)](https://github.com/asokolsky/agent-orchestra/blob/main/src/agent_orchestra/persisted_enum.py:39) rejects non-strings and unknown future values at the read boundary.
- The injected failure function translates malformed persisted data into the subsystem’s stable domain error.
That failure callback would be unnecessary abstraction for a simple color enum, but it is justified for agent-orchestra’s persistence contract.
