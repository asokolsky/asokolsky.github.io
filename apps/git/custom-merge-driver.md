# Custom Git Merge Driver

Problem statement: how to merge generated files, e.g., JSON?

[how-to-write-a-custom-git-merge-driver](https://gregmicek.com/software-coding/2020/01/13/how-to-write-a-custom-git-merge-driver/)

## Mark Files as Generated

In `.gitattributes` assign an attribute
[linguist-generated](https://docs.github.com/en/repositories/working-with-files/managing-files/customizing-how-changed-files-appear-on-github)
to keep certain files from displaying in diffs by default.
```
releases/** linguist-generated
releases/manifest.json merge=json-manifest
```

## Specify Merge Driver to Use

Change repo config in Makefile:
```
# This is the base directory for this repo
BASE_DIR:=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))

...

# setup the various git configuration for this repo
.PHONY: setup
setup:
    git config merge.json-manifest.name "merge manifests.json"
    git config merge.json-manifest.driver "${BASE_DIR}scripts/json-manifest-merge.py %O %A %B"

```

## Merge Driver Implementation

Finally, `merge-json.py`
```python
{% include_relative merge-json.py %}
```
