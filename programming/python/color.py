from enum import Enum
from typing import Union


class Color(str, Enum):
    red = 'Red'
    green = 'Green'
    blue = 'Blue'
    black = 'Black'

    @classmethod
    def is_dark(cls, st: Union[str, 'Color']) -> bool:
        return st in [cls.black]

    @classmethod
    def is_primary(cls, st: Union[str, 'Color']) -> bool:
        return st in [cls.red, cls.green, cls.black]

    @classmethod
    def is_valid(cls, st: Union[str, 'Color']) -> bool:
        return st in Color._value2member_map_

    def __repr__(s):
        '''
        To enable Color serialization as a string...
        '''
        # default implementation
        #type_ = type(self)
        #module = type_.__module__
        #qualname = type_.__qualname__
        #return f"<{module}.{qualname} object at {hex(id(self))}>"
        return repr(s.value)
