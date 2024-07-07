# PC Hardware Benchmarking

## PyPerformance

https://pyperformance.readthedocs.io

### Latitude 7490

[Latitude 7490](../dell/latitude-7490.html) runs Python 3.10.12.

System Configuration:
```
{% include_relative latitude-pyperf-config.txt %}
```

Tuning was NOT done to preserve the power efficiency of the laptop.

Running performance test:
```
~/Projects/pyperf > pyperformance run -o latitude.json
```

### Thinkpad P52

[Thinkpad P52](../lenovo/thinkpad-p52.html) runs Python 3.10.12.

System Configuration:
```
{% include_relative p52-pyperf-config.txt %}
```

Tuning was NOT done to preserve the power efficiency of the laptop.

## Latitude 7490 vs Thinkpad P52

```
{% include_relative latitude-vs-p52.txt %}
```
