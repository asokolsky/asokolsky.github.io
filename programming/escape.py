from enum import Enum
from typing import List


#
# Console output embellished with the following color chars
#
class Escapes(str, Enum):
    '''
    Escape characters an app, e.g. terraform, can use to color console output
    '''
    red = "\x1b[31m"
    reset = "\x1b[0m"
    bright = "\x1b[1m"

    @classmethod
    def unescape(cls, inp: str) -> str:
        '''
        Remove escape chars from string
        '''
        out: List[str] = []

        while inp:
            found = ''
            for _, strvalue in cls._value2member_map_.items():
                if inp.startswith(strvalue):
                    found = strvalue
                    break
            if found:
                inp = inp[len(found):]
            else:
                out.append(inp[0:1])
                inp = inp[1:]
        return ''.join(out)
