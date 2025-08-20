# One-liners

## Compare command output with expectations

```sh
diff -u expected.txt <(some command)
```

## URL-decode CLI

```
echo -n "%21%20" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
```

## Rename the files to lowercase

Try this:
```sh
for file in * ; do lower=$(echo $file | tr A-Z a-z) && [[ $lower != $file ]] && echo mv $file $lower ;done
```
To do the job remove the `echo`.
