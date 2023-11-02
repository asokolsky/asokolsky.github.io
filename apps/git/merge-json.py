'''
This is a git custom JSON merge driver.  It takes 3 args:
    - the "old" file
    - the "new" file
    - the "merged" file, where we should write the result.
We assume that the file is a JSON object that we can simply "merge" (.update)
'''
import sys
import json

if __name__ == '__main__':
    old_path, new_path, dest_path = sys.argv[1:]

    with open(old_path) as fh:
        old = json.load(fh)
    with open(new_path) as fh:
        new = json.load(fh)
    old.update(new)  # merge

    # write out the merged map
    with open(dest_path, 'w') as fh:
        fh.write(json.dumps(new, indent=4))
