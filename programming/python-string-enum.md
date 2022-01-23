# String Enum in Python3


[Bare Python's enum](https://docs.python.org/3/library/enum.html) is not good
enough: Int representation may be efficient, but it is not human readable after
it is serialized.

It would be nice to have a string enum.  Multiple inheritance to the resque!

```
from enum import Enum
from typing import Union

class Color( str, Enum ):
    red = 'Red'
    green = 'Green'
    blue = 'Blue'
    black = 'Black'

    @classmethod
    def is_dark( cls, st: Union[ str, 'Color' ] ) -> bool:
        return st in [ cls.black ]

    @classmethod
    def is_primary( cls, st: Union[ str, 'Color' ] ) -> bool:
        return st in [ cls.red, cls.green, cls.black  ]

    @classmethod
    def is_valid( cls, st: Union[ str, 'Color' ] ) -> bool:
        return st in Color._value2member_map_

    def __repr__( s ):
        'To enable Color serialization as a string...'
        return repr( s.value )
```

Let's see how this works for Color user...

```
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
