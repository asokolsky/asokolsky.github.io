# Programming Best Practices

Language specific:

* [C Style Guide](https://peps.python.org/pep-0007/)
* [Python Style Guide](https://peps.python.org/pep-0008/)

Here are few things TODO no matter what programming language you use.

## White Space Hygiene

Tabs vs spaces: spaces only.

Configure your IDE to:

* eliminate trailing white spaces;
* eliminate trailing newlines in the file.

[My vscode config](/apps/vscode/)

## Width Guides

I try to limit my code width to 80 columns.  In vscode I use a `ruler` to
provide such a guide.

[My vscode config](/apps/vscode/)

## Sizing Your Functions

If the function does not fit on your screen - it is too big.

## Naming Best Practices

[Naming best practices](best-practices-naming.html)

## Watch Your Constructor / Initializer

Constructor (initializer in python) does not return value and just initializes
the space allocated for the object.  Therefore, in its body, do NOT perform any
action that may fail.  You can still raise an exception though.

## Design Best Practices

[Design Best Practices](best-practices-design.html)
