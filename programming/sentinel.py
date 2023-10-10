'''
https://stackabuse.com/python-specific-design-patterns/

Sometimes we're faced with the challenge of distinguishing between the absence
of a value and a value that's actually set to None or some other default.
Simply relying on typical default values might not suffice.

The Sentinel Object Pattern offers a solution to this dilemma. By creating a
unique, unmistakable object that serves as a sentinel, we can differentiate
between genuinely absent values and default ones.
'''

# Our sentinel object
MISSING = object()


class Cache:
    def __init__(self):
        self._storage = {}

    def set(self, key, value):
        self._storage[key] = value

    def get(self, key):
        # Return the value if it exists, otherwise return the sentinel object
        return self._storage.get(key, MISSING)


# Usage
cache = Cache()
cache.set("username", None)

# Fetching values
result = cache.get("username")
if result is MISSING:
    print("Key not found in cache!")
else:
    print(f"Found value: {result}")
