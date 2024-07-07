# PC Hardware Benchmarking

## pyperformance

https://pyperformance.readthedocs.io

### Latitude 7490

[Latitude 7490](../dell/latitude-7490.html) runs Python 3.10.12.

Installed python 3.12 with headers:
```sh
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.12 python3.12-dev
```
Then install pip:
```sh
wget https://bootstrap.pypa.io/get-pip.py
python3.12 get-pip.py
```
verify:
```
> pip3 --version
pip 24.1.1 from /home/alex/.local/lib/python3.12/site-packages/pip (python 3.12)
```

Install pyperformance:
```sh
python3.12 -m pip install pyperformance
```

System Configuration:
```
{% include_relative latitude-pyperf-config.txt %}
```

Tuning was NOT done to ensure power efficiency of the laptop.

Run performance test:
```sh
pyperformance run --python=/usr/bin/python3.12 -o latitude.json
```

### Thinkpad P52

[Thinkpad P52](../lenovo/thinkpad-p52.html) runs Python 3.10.12.

System Configuration:
```
{% include_relative p52-pyperf-config.txt %}
```

## Latitude 7490 vs Thinkpad P52

```
{% include_relative latitude-vs-p52.txt %}
```
