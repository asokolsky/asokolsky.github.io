import itertools
from typing import List


def generate_all_words(chars: str, length: int) -> List[str]:
    '''
    Given the alphabet of chars, generate all possible words of given length
    '''
    def foo(syms: str, length: int):
        yield from itertools.product(*([syms] * length))

    return [''.join(word) for word in foo(chars, length)]
