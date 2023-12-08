# jsonpickle

From https://realpython.com/python-serialize-data/#use-formats-foreign-to-python

`customize-pickle/models.py`:

```python
import time
from dataclasses import dataclass

@dataclass
class User:
    name: str
    password: str

    def __getstate__(self):
        state = self.__dict__.copy()
        state["timestamp"] = int(time.time())
        del state["password"]
        return state

    def __setstate__(self, state):
        self.__dict__.update(state)
        with open("/dev/random", mode="rb") as file:
            self.password = file.read(8).decode("ascii", errors="ignore")
```

Use `jsonpickle` to serialize/deserialize instance of class `User`:
```
>>> import jsonpickle
>>> from models import User
>>> user = User(name="John", password="*%!U8n9erx@GdqK(@J")
>>> user_json = jsonpickle.dumps(user, indent=4)
>>> print(user_json)
{
    "py/object": "models.User",
    "py/state": {
        "name": "John",
        "timestamp": 1699805990
    }
}

>>> jsonpickle.loads(user_json)
User(name='John', password='\\\x06,\x19')
```
