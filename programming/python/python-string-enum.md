# String Enum in Python


[Bare Python enum](https://docs.python.org/3/library/enum.html) is not good
enough: Int representation may be efficient, but it is not human readable,
especially after it is serialized.

Wouldn't it be nice to have a string enum?  Multiple inheritance to the resque!

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

This subject gets traction!  Checkout this
[FastAPI write-up](https://fastapi-utils.davidmontague.xyz/user-guide/basics/enums/)!
