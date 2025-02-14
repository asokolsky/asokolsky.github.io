# jsonnet

See:

* [jsonnet Command Line](https://www.mankier.com/1/jsonnet)
* [tutorial](https://jsonnet.org/learning/tutorial.html)
* [language reference](https://jsonnet.org/ref/language.html)
* [repo](https://github.com/google/jsonnet)
* [go implementation](https://github.com/google/go-jsonnet)
* [python binding](https://pypi.org/project/jsonnet/)
* there is also a [bundler](https://github.com/jsonnet-bundler/jsonnet-bundler)

## Install

On MacOS this did it:

```sh
brew install jsonnet
```

```
> jsonnet --version
Jsonnet commandline interpreter v0.20.0
```

## Example Use

```
> jsonnet --tla-str prefix="Happy Hour " \
  --tla-code brunch=true \
  top-level-tla.jsonnet
{
   "Happy Hour Bloody Mary": {
      "garnish": "Celery salt & pepper",
      "ingredients": [
         {
            "kind": "Vodka",
            "qty": 1.5
         },
         {
            "kind": "Tomato Juice",
            "qty": 3
         },
         {
            "kind": "Lemon Juice",
            "qty": 1.5
         },
         {
            "kind": "Worcestershire",
            "qty": 0.25
         },
         {
            "kind": "Tobasco Sauce",
            "qty": 0.14999999999999999
         }
      ],
      "served": "Tall"
   },
   "Happy Hour Mimosa": {
      "garnish": "Orange Slice",
      "ingredients": [
         {
            "kind": "Cheap Sparkling Wine",
            "qty": 3
         },
         {
            "kind": "Orange Juice",
            "qty": 3
         }
      ],
      "served": "Champagne Flute"
   },
   "Happy Hour Pina Colada": {
      "garnish": "Pineapple slice",
      "ingredients": [
         {
            "kind": "Rum",
            "qty": 3
         },
         {
            "kind": "Pineapple Juice",
            "qty": 6
         },
         {
            "kind": "Coconut Cream",
            "qty": 2
         },
         {
            "kind": "Ice",
            "qty": 12
         }
      ],
      "served": "Frozen"
   }
}
```

[More examples](https://github.com/google/jsonnet/tree/master/examples).

## Missing switch

`switch` is missing but can be replaced with a function.

`switch.libsonnet`:
```
{% include_relative switch.libsonnet %}
```
Then in your `foo.jsonnet`:
```
local switch = import 'switch.libsonnet';
local replicas = switch(cluster.account, {
   prod: 100,
   stage: 10,
   dev: 1,
}),
```

## Debugging Output

This prints value of `clusters` and returns it:
```
std.trace('clusters: %s' % std.manifestJson(clusters),  clusters)
```

## std.manifestJsonMinified

Produce a string of JSON:
```json
std.manifestJsonMinified({
    account: dev_account_id,
    service: business_service,
    dir: kms_module_dir,
  }),
```
