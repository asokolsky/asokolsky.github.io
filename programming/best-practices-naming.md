# Naming Best Practices

[Other best practices](best-practices.html)

## Mixing Cases

Conventions:

* [snake_case](https://en.wikipedia.org/wiki/Snake_case),
* [SCREAMING_SNAKE_CASE](https://developer.mozilla.org/en-US/docs/Glossary/Snake_case),
* [kebab-case](https://en.wikipedia.org/wiki/Letter_case#Kebab_case),
* [dromedaryCase](https://en.wikipedia.org/wiki/Camel_case) /
* [CamelCase](https://en.wikipedia.org/wiki/Camel_case).

Pick the right one (you decide what that means), stick to it.

## Choosing Case

Most commonly used approach:

* have class name capitalized, use CamelCase;
* methods start with a lower case letter, use dromedaryCase.

## Functional Brackets

There are established (English) naming brackets:

* init(ialize) / shut(down)
* begin / end
* start / finish
* enter / exit
* acquire / release
* lock / unlock
* get / put
* push / pop

Hence, if you have `begin_foo` make sure the `end_foo` is defined.  Not
`finish_foo`.

The above list is ordered by narrowing the scope.  In other words, I find this
logical:

```
o.init()
    o.start()
        o.push(123)
        o.pop()
    o.finish()
o.shut()
```

In contrast, this would alarm me:
```
o.push(123)
    o.start()
        o.init()
        o.finish()
    o.shut()
o.pop()
```

## Naming Verbosity vs Scope

The smaller the scope of the identifier, the shorter it can be.

It is OK for a local variable to be called `port`, even `p`.  A global variable
holding the same should be descriptive, e.g. `the_web_server_port`.

## Naming Specificity

When naming variables:

* DO use descriptive application-specific terms
* DO NOT use generic type alone

For example:

* BAD: `port`, `address`
* GOOD: `app_port`, `ssh_port`, `destination_address`

## Watch Your Language: Noun vs Verb, Singular vs Plural

Be intentional about your language and use the nouns and verbs consistently,
e.g.:

* singular noun for a class name
* plural nouns for collections
* verbs for methods and functions

## Naming Predicates

Predicate is a function returning boolean value with no side-effects.

Recognizers are predicates.  Suppose you have class `Car` defined.  What should
you call a car recognizer?  Here are few conventions to pick from:

* `is_car`
* `isCar`
* `carp` as in
[Lisp](https://www.cs.cmu.edu/Groups/AI/html/cltl/clm/node69.html)
* `car?` as in
[Scheme](https://www.r6rs.org/final/html/r6rs/r6rs-Z-H-14.html#node_sec_11.5)

DO use consistent names for predicates.
